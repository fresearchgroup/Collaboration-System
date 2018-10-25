from django.db import models
from Group.models import Group
from Community.models import Community
import os, uuid

def get_file_path(instance, filename):
    ext = filename.split('.')[-1]
    filename = "%s.%s" % (uuid.uuid4(), ext)
    return os.path.join('category', filename)

class Category(models.Model):
	name = models.CharField(max_length=100)
	desc = models.TextField()
	image = models.ImageField(null=True, upload_to=get_file_path)

	def __str__(self):
		return self.name

class GroupCategory(models.Model):
	category = models.ForeignKey(Category, related_name='groupcategories')
	group = models.ForeignKey(Group, related_name='groupcategories')
	community = models.ForeignKey(Community, null=True, related_name='groupcategories')	

