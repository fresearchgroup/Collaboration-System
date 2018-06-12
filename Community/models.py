from django.db import models
from django.contrib.auth.models import User
from django.contrib.auth.models import Group as Roles
from BasicArticle.models import Articles
from Group.models import Group
from Course.models import Course
import os, uuid

def get_file_path(instance, filename):
    ext = filename.split('.')[-1]
    filename = "%s.%s" % (uuid.uuid4(), ext)
    return os.path.join('community', filename)

class Community(models.Model):

        name = models.CharField(max_length=100)
        desc = models.TextField()
        image = models.ImageField(null=True, upload_to=get_file_path)
        category = models.CharField(max_length=100)
        tag_line = models.CharField(null=True, max_length=500)
        created_at = models.DateTimeField(null=True, auto_now_add=True)
        created_by = models.ForeignKey(User,null =True, related_name='communitycreator')
        forum_link = models.CharField(null=True, max_length=100)

        def __str__(self):
            return self.name


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
	category = models.CharField(max_length=100)
	tag_line = models.CharField(null=True, max_length=500)
	purpose = models.TextField()
	requestedby = models.ForeignKey(User, null=True)
	email = models.CharField(null=True, max_length=100)
	status = models.CharField(null=True, max_length=100)

	def __str__(self):
		return self.name

class CommunityCourses(models.Model):
	course = models.ForeignKey(Course, null=True, related_name='communitycourses')
	user = models.ForeignKey(User, null=True, related_name='communitycourses')
<<<<<<< HEAD
	community = models.ForeignKey(Community, null=True, related_name='communitycourses')
=======
	community = models.ForeignKey(Community, null=True, related_name='communitycourses')
>>>>>>> 4e9d5cfe150a17592b3168794230d17099aa2ed2
