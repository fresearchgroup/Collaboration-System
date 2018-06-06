from django.db import models

# Create your models here.
class Events(models.Model):
	event-source  = models.CharField(max_length = 10)
	event.community-id = models.IntegerField()
	event.user-id = models.CharField(max_length = 15)
	event_name = models.CharField(max_length = 15)
	host = models.CharField(max_length = 15)
	ip-address = models.CharField(max_length = 15)
	path-info = models.CharField(max_length = 30)
	referer = models.CharField(max_length = 30)
	session-id = models.CharField(max_length = 50)

	def __str__(self):
        return self.name
