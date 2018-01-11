from django.db import models
from django.contrib.auth.models import User
from django.contrib.auth.models import Group as Roles
from BasicArticle.models import Articles
from Group.models import Group

# Create your models here.
class Community(models.Model):
	name = models.CharField(max_length=100)
	desc = models.TextField()
	category = models.CharField(max_length=100)
	tag_line = models.CharField(null=True, max_length=500)
	created_at = models.DateTimeField(null=True, auto_now_add=True)

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
		return reverse('article_view', kwargs={'pk': self.id})

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
