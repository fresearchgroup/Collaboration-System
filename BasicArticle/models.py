from django.db import models
from django.contrib.auth.models import User

class Articles(models.Model):
	title = models.CharField(max_length=100)
	body = models.TextField()
	created_at = models.DateTimeField(auto_now_add=True)
	created_by = models.ForeignKey(User, null=True, related_name='articles')