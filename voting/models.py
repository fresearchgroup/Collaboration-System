from django.db import models
from django.contrib.auth.models import User
from Community.models import Community
from BasicArticle.models import Articles,get_file_path

class ArticleVotes(models.Model): 
	article = models.OneToOneField(Articles,on_delete=models.CASCADE)
	upvote = models.PositiveIntegerField(default=0)
	downvote = models.PositiveIntegerField(default=0)
	report = models.PositiveIntegerField(default=0)
	published_by = models.ForeignKey(User,null=True)

	def __str__(self):
		return self.article.title

class VotingFlag(models.Model): 
	article = models.ForeignKey(Articles,on_delete=models.CASCADE)
	user = models.ForeignKey(User,on_delete=models.CASCADE)
	upflag = models.BooleanField(default=False)
	downflag = models.BooleanField(default=False)
	reportflag = models.BooleanField(default=False)
	report_reason = models.CharField(max_length=100,default=" ")

	def __str__(self):
		return self.article.title + "-" + self.user.username

class ArticleReport(models.Model):
	community = models.ForeignKey(Community,on_delete=models.CASCADE)
	article = models.OneToOneField(Articles,on_delete=models.CASCADE)
	no_of_report = models.PositiveIntegerField(default=0)

	def __str__(self):
		return self.article.title + "-" + self.community.name

class Badges(models.Model):
	user = models.OneToOneField(User,on_delete=models.CASCADE)
	articles_contributed_author = models.PositiveIntegerField(default=0)
	articles_published_author = models.PositiveIntegerField(default=0)
	articles_published_publisher = models.PositiveIntegerField(default=0)
	articles_revised_publisher = models.PositiveIntegerField(default=0)

	def __str__(self):
		return self.user.username
