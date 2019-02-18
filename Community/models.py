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

def get_file_path(instance, filename):
    ext = filename.split('.')[-1]
    filename = "%s.%s" % (uuid.uuid4(), ext)
    return os.path.join('community', filename)

class Community(MPTTModel):

		name = models.CharField(max_length=100)
		desc = models.TextField()
		image = models.ImageField(null=True, upload_to=get_file_path)
		image_thumbnail = models.ImageField(null=True, upload_to=get_file_path)
		category = models.ForeignKey(Category,null =True, related_name='communitycategory' )
		tag_line = models.CharField(null=True, max_length=500)
		created_at = models.DateTimeField(null=True, auto_now_add=True)
		created_by = models.ForeignKey(User,null =True, related_name='communitycreator')
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

class RequestCommunityCreation(models.Model):
	name = models.CharField(null=True, max_length=100)
	desc = models.TextField()
	category = models.ForeignKey(Category,null =True)
	tag_line = models.CharField(null=True, max_length=500)
	purpose = models.TextField()
	requestedby = models.ForeignKey(User, null=True)
	email = models.CharField(null=True, max_length=100)
	status = models.CharField(null=True, default ='Request', max_length=100)

	def __str__(self):
		return self.name

class CommunityCourses(models.Model):
	course = models.ForeignKey(Course, null=True, related_name='communitycourses')
	user = models.ForeignKey(User, null=True, related_name='communitycourses')
	community = models.ForeignKey(Community, null=True, related_name='communitycourses')

class CommunityMedia(models.Model):
	media = models.ForeignKey(Media, null=True, related_name='communitymedia')
	user = models.ForeignKey(User, null=True, related_name='communitymedia')
	community = models.ForeignKey(Community, null=True, related_name='communitymedia')	