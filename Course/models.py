from django.db import models
from mptt.models import MPTTModel, TreeForeignKey
from django.contrib.auth.models import User
from BasicArticle.models import Articles
import os, uuid

def get_file_path(instance, filename):
    ext = filename.split('.')[-1]
    filename = "%s.%s" % (uuid.uuid4(), ext)
    return os.path.join('course', filename)

class Course(models.Model):
	title = models.CharField(max_length=100)
	body = models.TextField()
	image = models.ImageField(null=True,upload_to=get_file_path)
	created_at = models.DateTimeField(auto_now_add=True,null=True)
	created_by = models.ForeignKey(User,null=True,related_name='community_createdby')

	def __str__(self):
		return self.title

class Topics(MPTTModel):
	name = models.CharField(max_length=50)
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
	types = models.CharField(max_length=300 ,null=True)

class Videos(models.Model):
	video = models.CharField(max_length=300)
	desc = models.TextField()
	topics = models.ForeignKey(Topics,null=True, related_name='topics_videos')

class TopicArticle(models.Model):
	article = models.ForeignKey(Articles, related_name='topics_artic')
	topics = models.ForeignKey(Topics,null=True, related_name='topics_articles')
