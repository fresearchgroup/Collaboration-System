from django.db import models

class Articles(models.Model):
	title = models.CharField(max_length=100)
	body = models.TextField()
	created_at = models.DateTimeField(auto_now_add=True)