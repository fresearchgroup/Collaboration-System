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
<<<<<<< HEAD
	created_by = models.ForeignKey(User,null=True)
	views = models.PositiveIntegerField(default=0)
	state = models.ForeignKey(States, null=True)
=======
	created_by = models.ForeignKey(User,null=True,related_name='article_author')
	views = models.PositiveIntegerField(default=0)
	userview = models.ManyToManyField(User)
	state = models.ForeignKey(States, null=True,related_name='articleworkflow')
>>>>>>> 4e9d5cfe150a17592b3168794230d17099aa2ed2

	def __str__(self):
		return self.title

class ArticleViewLogs(models.Model):
<<<<<<< HEAD
    article = models.ForeignKey(Articles)
=======
    article = models.ForeignKey(Articles, related_name='articleviews')
>>>>>>> 4e9d5cfe150a17592b3168794230d17099aa2ed2
    ip = models.CharField(max_length=40)
    session = models.CharField(max_length=40)
    created = models.DateTimeField(auto_now_add=True)
