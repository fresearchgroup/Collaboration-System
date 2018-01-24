from django.db import models
from django.contrib.auth.models import User

# Create your models here.

class Feedback(models.Model):
	title = models.CharField(max_length=100)
	body = models.TextField()
	user = models.ForeignKey(User, null=True, related_name='fuser')
	provided_at = models.DateTimeField(null=True, auto_now_add=True)

class Faq(models.Model):
	category = models.CharField(max_length=100)
	question = models.CharField(max_length=100)
	answer = models.CharField(max_length=100)
