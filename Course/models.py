from django.db import models
from mptt.models import MPTTModel, TreeForeignKey
from Community.models import Community

class Course(models.Model):
	name = models.CharField(max_length=100)
	desc = models.TextField()
	community = models.ForeignKey(Community, null=True, related_name='community_course')

	def __str__(self):
		return self.name

class Topics(MPTTModel):
	name = models.CharField(max_length=50, unique=True)
	parent = TreeForeignKey('self', null=True, blank=True, related_name='children', db_index=True)
	course = models.ForeignKey(Course,null=True, related_name='course_topics')

	class MPTTMeta:
		order_insertion_by = ['name']

	def __str__(self):
		return self.name

class Links(models.Model):
	link = models.CharField(max_length=300)
	desc = models.TextField()
	topics = models.ForeignKey(Topics,null=True, related_name='topics_links')

class videos(models.Model):
	video = models.CharField(max_length=300)
	desc = models.TextField()
	topics = models.ForeignKey(Topics,null=True, related_name='topics_links')