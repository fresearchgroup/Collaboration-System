from django.db import models
from django.contrib.auth.models import User
from django.contrib.auth.models import Group as Roles
from BasicArticle.models import Articles
from Group.models import Group
from Course.models import Course
import os, uuid
from Media.models import Media
from mptt.models import MPTTModel, TreeForeignKey
from Categories.models import Category
from django.db import connection
from workflow.models import States
import datetime

def get_file_path(instance, filename):
    ext = filename.split('.')[-1]
    filename = "%s.%s" % (uuid.uuid4(), ext)
    return os.path.join('community', filename)


class Locations(models.Model):
	city = models.CharField(max_length=30, null=True)
	district = models.CharField(max_length=30, null=True)
	state = models.CharField(max_length=30, null=True)
	pincode = models.PositiveIntegerField(null=True)

class Community(MPTTModel):
	
		name = models.CharField(max_length=100)
		area = models.CharField(max_length=30, null=True)
		district = models.CharField(max_length=30, null=True)
		city = models.CharField(max_length=30, null=True)
		state = models.CharField(max_length=30, null=True)
		pincode = models.CharField(max_length=6, null=True)
		latitude = models.FloatField(default=0)
		longitude = models.FloatField(default=0)
		contribution_status_choices = (
			('Ongoing', 'Ongoing'),
			('Completed', 'Completed'),
		)
		contribution_status = models.CharField(choices=contribution_status_choices, max_length=20, default='Ongoing')
		desc = models.TextField()
		image = models.ImageField(null=True, upload_to=get_file_path)
		image_thumbnail = models.ImageField(null=True, upload_to=get_file_path)
		# category = models.ForeignKey(Category,null =True, related_name='communitycategory' )
		tag_line = models.CharField(null=True, max_length=500)
		created_at = models.DateTimeField(null=True, auto_now_add=True)
		created_by = models.ForeignKey(User,null =True, related_name='communitycreator')
		contributed_by = models.ForeignKey(User,null =True, related_name='contributed_by')
		forum_link = models.CharField(null=True, max_length=100)
		forum = models.PositiveIntegerField(null=True)
		parent = TreeForeignKey('self', null=True, blank=True, related_name='children', db_index=True)

		def __str__(self):
			return self.name

		@classmethod
		def create_forum(cls, name, desc):
			try:
				cursor = connection.cursor()
				cursor.execute(''' select tree_id from forum_forum order by tree_id DESC limit 1''')
				tree_id = cursor.fetchone()[0] + 1
				slug = "-".join(name.lower().split())
				#return HttpResponse(str(tree_id))
				insert_stmt = (
					  "INSERT INTO forum_forum (created,updated,name,slug,description,link_redirects,type,link_redirects_count,display_sub_forum_list,lft,rght,tree_id,level,direct_posts_count,direct_topics_count) "
					  "VALUES (NOW(), NOW(), %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
					)
				data = (name, slug, desc, 0,0,0,1,1,2,tree_id,0,0,0)
				cursor.execute(insert_stmt, data)
				cursor.execute(''' select id from forum_forum order by id desc limit 1''')
				fid = str(cursor.fetchone()[0])
				forum_link = slug + '-' + fid
				return forum_link, fid
			except:
				return False, False


class CommunityMembership(models.Model):
	user = models.ForeignKey(User, related_name='communitymembership')
	community = models.ForeignKey(Community, related_name='communitymembership')
	role = models.ForeignKey(Roles, null=True, related_name='communitymembership')
	assignedon = models.DateTimeField(null=True, auto_now_add=True)

class CommunityArticles(models.Model):
	article = models.ForeignKey(Articles, related_name='communityarticles')
	user = models.ForeignKey(User, related_name='communityarticles')
	community = models.ForeignKey(Community, related_name='communityarticles')

	def get_absolute_url(self):
		from django.urls import reverse
		return reverse('article_view', kwargs={'pk': self.article_id})

class CommunityGroups(models.Model):
	group = models.ForeignKey(Group, null=True, related_name='communitygroups')
	user = models.ForeignKey(User, null=True, related_name='communitygroups')
	community = models.ForeignKey(Community, null=True, related_name='communitygroups')

# class RequestCommunityCreation(models.Model):
# 	name = models.CharField(null=True, max_length=100)
# 	desc = models.TextField()
# 	area = models.CharField(max_length=30, null=True)
# 	city = models.CharField(max_length=30, null=True)
# 	state = models.CharField(max_length=30, null=True)
# 	pincode = models.PositiveIntegerField(null=True)
# 	category = models.ForeignKey(Category,null =True)
# 	tag_line = models.CharField(null=True, max_length=500)
# 	purpose = models.TextField()
# 	requestedby = models.ForeignKey(User, null=True)
# 	email = models.CharField(null=True, max_length=100)
# 	status = models.CharField(null=True, default ='Request', max_length=100)
# 	parent = models.ForeignKey(Community, null=True, related_name='communityparent')

# 	def __str__(self):
# 		return self.name

class RequestCommunityCreation(models.Model):
	requestedby = models.ForeignKey(User, null=True)
	requestedon = models.DateTimeField(null=True, auto_now_add=True)
	email = models.CharField(null=True, max_length=100)
	parent = models.ForeignKey(Community, null=True, related_name='communityparent')

	# def __str__(self):
	# 	return self.requestedby

class RequestCommunityCreationAssignee(models.Model):
	requestcommunity = models.ForeignKey(RequestCommunityCreation, related_name='requestcommunitycreationassignee')
	assignedto = models.ForeignKey(User, null=True)
	assignedon = models.DateTimeField(null=True, auto_now_add=True)

class RequestCommunityCreationDetails(models.Model):
	requestcommunity = models.ForeignKey(RequestCommunityCreation, related_name='requestcommunitycreation')
	name = models.CharField(null=True, max_length=100)
	desc = models.TextField()
	district = models.CharField(max_length=30, null=True)
	area = models.CharField(max_length=30, null=True)
	city = models.CharField(max_length=30, null=True)
	state = models.CharField(max_length=30, null=True)
	pincode = models.CharField(max_length=6, null=True)
	latitude = models.FloatField(default=0)
	longitude = models.FloatField(default=0)
	status = models.CharField(null=True, default='Requested', max_length=100)
	actionby = models.ForeignKey(User, null=True)
	actionon = models.DateTimeField(null=True, auto_now_add=True)
	reason = models.TextField(null=True)

	# def __str__(self):
	# 	return self.name

class CommunityCourses(models.Model):
	course = models.ForeignKey(Course, null=True, related_name='communitycourses')
	user = models.ForeignKey(User, null=True, related_name='communitycourses')
	community = models.ForeignKey(Community, null=True, related_name='communitycourses')

class CommunityMedia(models.Model):
	media = models.ForeignKey(Media, null=True, related_name='communitymedia')
	user = models.ForeignKey(User, null=True, related_name='communitymedia')
	community = models.ForeignKey(Community, null=True, related_name='communitymedia')	

def get_doc_upload_path(instance, filename):
	now = datetime.datetime.now()
	filename = f'{now.year}' + "_" + f'{now.month}' + "_" + f'{now.day}' + "_" + f'{now.hour}' + f'{now.minute}' + "_" + f'{instance.community.pk}' + "_" + instance.community.name + "_received.docx"
	return os.path.join('writeup', f'{instance.community.pk}', filename)

class MergedArticles(models.Model):
	community = models.ForeignKey(Community, related_name='communitymergedarticles')
	introduction = models.TextField(null=True)
	architecture = models.TextField(null=True)
	rituals = models.TextField(null=True)
	ceremonies = models.TextField(null=True)
	tales = models.TextField(null=True)
	moreinfo = models.TextField(null=True)
	state = models.ForeignKey(States, null=True,related_name='mergedarticlecurrentstate')
	changedby = models.ForeignKey(User,null=True,related_name='mergedarticle_author')
	changedon = models.DateTimeField(auto_now_add=True)
	originalarticles = models.TextField(null=True)
	originalmedia = models.TextField(null=True)
	publishedlink = models.CharField(max_length=200, null=True)
	document_sent = models.CharField(max_length=500, null=True)
	document_received = models.FileField(null=True, upload_to=get_doc_upload_path)

class MergedArticleStates(models.Model):
	mergedarticle = models.ForeignKey(MergedArticles, related_name='mergedarticleinfo')
	state = models.ForeignKey(States, null=True,related_name='mergedarticleworkflow')
	changedby = models.ForeignKey(User,null=True,related_name='mergedarticlechangedby')
	changedon = models.DateTimeField(null=True, auto_now_add=True)
	comments = models.TextField(null=True)
	introduction = models.TextField(null=True)
	architecture = models.TextField(null=True)
	rituals = models.TextField(null=True)
	ceremonies = models.TextField(null=True)
	tales = models.TextField(null=True)
	moreinfo = models.TextField(null=True)
	document_sent = models.CharField(max_length=500, null=True)
	document_received = models.CharField(max_length=500, null=True)
