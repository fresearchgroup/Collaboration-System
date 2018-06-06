from django.db import models
from django.contrib.auth.models import User

# Create your models here.

class Feedback(models.Model):
	title = models.CharField(max_length=100)
	body = models.TextField()
	user = models.ForeignKey(User, null=True, related_name='fuser')
	provided_at = models.DateTimeField(null=True, auto_now_add=True)

class FaqCategory(models.Model):
	name = models.CharField(max_length=50)
	desc = models.TextField()

	def __str__(self):
		return self.name

class Faq(models.Model):
	category = models.ForeignKey(FaqCategory, null=True, related_name='faqcategory')
	flow = models.FloatField(default=0.0)
	question = models.CharField(max_length=200)
	answer = models.TextField()
