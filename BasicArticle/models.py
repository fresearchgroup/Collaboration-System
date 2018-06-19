from django.db import models
from django.contrib.auth.models import User
from workflow.models import States
import os, uuid

def get_file_path(instance, filename):
    ext = filename.split('.')[-1]
    filename = "%s.%s" % (uuid.uuid4(), ext)
    return os.path.join('article', filename)

class Articles(models.Model):
	title = models.CharField(max_length=100)
	body = models.TextField(null=True)
	image = models.ImageField(null=True,upload_to=get_file_path)
	created_at = models.DateTimeField(auto_now_add=True)
	created_by = models.ForeignKey(User,null=True,related_name='article_author')
	views = models.PositiveIntegerField(default=0)
	state = models.ForeignKey(States, null=True,related_name='articleworkflow')

	def __str__(self):
		return self.title

class ArticleViewLogs(models.Model):
    article = models.ForeignKey(Articles, related_name='articleviews')
    ip = models.CharField(max_length=40)
    session = models.CharField(max_length=40)
    created = models.DateTimeField(auto_now_add=True)
