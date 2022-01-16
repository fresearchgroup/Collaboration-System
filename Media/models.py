from django.db import models
from django.contrib.auth.models import User
from workflow.models import States
import os, uuid
from django.conf import settings
from metadata.models import Metadata
from workflow.views import get_initial_state

def get_file_path(instance, filename):
	ext = filename.split('.')[-1]
	filename = "%s.%s" % (uuid.uuid4(), ext)
	ext = ext.lower()
	if ext == 'mp3' or ext == 'wav' or ext == 'ogg' :
		return os.path.join('audio', filename)
	if ext == 'jpg' or ext == 'jpeg' or ext == 'png':
		return os.path.join('images', filename)
	if ext == 'vob' or ext == 'webm' or ext == 'avi' or ext == 'mp4' or ext == 'wmv':
		return os.path.join('video', filename)

class Media(models.Model):
	media_types = (
		('IMAGE', 'Image'),
        ('AUDIO', 'Audio'),
        ('VIDEO', 'Video'),
    )
	mediatype = models.CharField(choices=media_types, max_length=10, default='IMAGE')	
	title = models.CharField(max_length=100)
	mediafile = models.FileField(null=True,upload_to=get_file_path)
	medialink = models.CharField(max_length=300, null=True)
	metadata = models.ForeignKey(Metadata, null=True,related_name='media_metadata')
	references = models.TextField(null=True)
	state = models.ForeignKey(States, null=True,related_name='mediacurrentstate')
	created_at = models.DateTimeField(auto_now_add=True)
	created_by = models.ForeignKey(User,null=True,related_name='media_author')
	published_on=models.DateTimeField(null=True)
	published_by=models.ForeignKey(User,null=True,related_name='media_publisher')
	views = models.PositiveIntegerField(default=0)
	publishedlink = models.CharField(max_length=200, null=True)

	def get_absolute_url(self):
		from django.urls import reverse
		return reverse('media_view', kwargs={'pk': self.id})

class MediaStates(models.Model):
	media = models.ForeignKey(Media, related_name='mediainfo')
	state = models.ForeignKey(States, null=True,related_name='mediaworkflow')
	changedby = models.ForeignKey(User,null=True,related_name='mediachangedby')
	changedon = models.DateTimeField(null=True, auto_now_add=True)
	comments = models.TextField(null=True)
