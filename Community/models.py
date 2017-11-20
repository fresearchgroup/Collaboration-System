from django.db import models
from django.contrib.auth.models import User
from django.contrib.auth.models import Group as Roles
from BasicArticle.models import Articles

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
