from django.db import models
from Community.models import Community
from django.contrib.auth.models import User
from BasicArticle.models import Articles

#score of a user in different communities
class CommunityReputaion(models.Model): 
	community = models.ForeignKey(Community ,on_delete = models.CASCADE)
	user = models.ForeignKey(User , on_delete = models.CASCADE)
	score = models.IntegerField()

#reputation values and operation for any resource in the system
class ResourceScore(models.Model):
    can_vote_unpublished = models.BooleanField(default=True)
    upvote_value = models.IntegerField()
    downvote_value = models.IntegerField()
    can_report = models.BooleanField(default=True)
    publish_value = models.IntegerField(null = True)


#score needed to achieve a certain role
class UserScore(models.Model):
    author = models.IntegerField()
    publisher = models.IntegerField()

#it will store score of a particular article
class ArticleScoreLog(models.Model):
    article = models.OneToOneField(Articles ,on_delete = models.CASCADE)
    upvote = models.IntegerField()
    downvote = models.IntegerField()
    reported = models.IntegerField()

class ArticleVotedByLogs(models.Model):
    user = models.ForeignKey(User ,on_delete = models.CASCADE)
    article = models.ForeignKey(Articles ,on_delete = models.CASCADE)
    upvoted = models.BooleanField(default=False)
    downvoted = models.BooleanField(default=False)
    reported = models.BooleanField(default=False)
