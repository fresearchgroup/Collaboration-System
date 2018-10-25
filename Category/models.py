from django.db import models
from Group.models import Group
from Community.models import Community

class Category(models.Model):
	name = models.CharField(max_length=100)
	desc = models.TextField()

	def __str__(self):
		return self.name

class GroupCategory(models.Model):
	category = models.ForeignKey(Category, related_name='groupcategories')
	group = models.ForeignKey(Group, related_name='groupcategories')
	community = models.ForeignKey(Community, null=True, related_name='groupcategories')	

