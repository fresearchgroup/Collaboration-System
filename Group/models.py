from django.db import models
from django.contrib.auth.models import User
from django.contrib.auth.models import Group as Roles
from BasicArticle.models import Articles
from UserRolesPermission.helpers import RandomFileName

# Create your models here.

class Group(models.Model):
	name = models.CharField(max_length=100)
	desc = models.TextField()
	image = models.ImageField(null=True,upload_to='group')
	visibility = models.BooleanField()
	created_at = models.DateTimeField(null=True, auto_now_add=True)

	def __str__(self):
		return self.name

class GroupMembership(models.Model):
	group = models.ForeignKey(Group, related_name='groupmembership')
	user = models.ForeignKey(User, related_name='groupmembership')
	role = models.ForeignKey(Roles, null=True, related_name='groupmembership')

class GroupArticles(models.Model):
	article = models.ForeignKey(Articles, related_name='grouparticles')
	user = models.ForeignKey(User, related_name='grouparticles')
	group = models.ForeignKey(Group, null=True, related_name='grouparticles')
	def get_absolute_url(self):
		from django.urls import reverse
		return reverse('article_view', kwargs={'pk': self.article_id})
