from django.db import models

# Create your models here.

class Course(models.Model):
	name = models.CharField(max_length=100)
	desc = models.TextField()
	image = models.ImageField(null=True, upload_to='course')\

class Topics(models.Model):
	name = models.CharField(max_length=50)
	course = models.ForeignKey(Course, related_name='course_topics')


class Links(models.Model):
	link = models.CharField(max_length=300)
	desc = models.TextField()
	topics = models.ForeignKey(Topics, related_name='topics_links')