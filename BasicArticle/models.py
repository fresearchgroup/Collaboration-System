from django.db import models
from workflow.models import Transitions
class Articles(models.Model):
	title = models.CharField(max_length=100)
	body = models.TextField()
	created_at = models.DateTimeField(auto_now_add=True)
	state = models.ForeignKey(Transitions, null=True,related_name='articleworkflow')

	def __str__(self):
		return self.title
