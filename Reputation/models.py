from django.db import models
from Community.models import Community
from django.contrib.auth.models import User
from BasicArticle.models import Articles
from Media.models import Media

#score of a user in different communities
class CommunityReputaion(models.Model): 
    community = models.ForeignKey(Community ,on_delete = models.CASCADE, null=True)
    user = models.ForeignKey(User , on_delete = models.CASCADE,null=True)
    upvote_count = models.IntegerField(default=0)
    downvote_count = models.IntegerField(default=0)
    published_count = models.IntegerField(default=0)
    published_by_me_count = models.IntegerField(default=0)

    def get_reputation_score(self):
        resource_score = ResourceScore.objects.get_or_create(resource_type='resource')[0]

        return self.upvote_count * resource_score.upvote_value - self.downvote_count * resource_score.downvote_value + self.published_count * resource_score.publish_value

#reputation values and operation for any resource in the system
class ResourceScore(models.Model):
    can_vote_unpublished = models.BooleanField(default=True)
    upvote_value = models.IntegerField(null=True, default=0)
    downvote_value = models.IntegerField(null=True, default=0)
    can_report = models.BooleanField(default=True)
    publish_value = models.IntegerField(null = True, default=0)
    resource_type = models.CharField(max_length=20, default='resource')

class BadgeScore(models.Model):
    articles_contributed_level_1 = models.IntegerField(default=0)
    articles_contributed_level_2 = models.IntegerField(default=0)
    articles_contributed_level_3 = models.IntegerField(default=0)
    articles_contributed_level_4 = models.IntegerField(default=0)
    articles_contributed_level_5 = models.IntegerField(default=0)
    my_articles_published_level_1 = models.IntegerField(default=0)
    my_articles_published_level_2 = models.IntegerField(default=0)
    my_articles_published_level_3 = models.IntegerField(default=0)
    my_articles_published_level_4 = models.IntegerField(default=0)
    my_articles_published_level_5 = models.IntegerField(default=0)
    articles_revised_by_me_level_1 = models.IntegerField(default=0)
    articles_revised_by_me_level_2 = models.IntegerField(default=0)
    articles_revised_by_me_level_3 = models.IntegerField(default=0)
    articles_revised_by_me_level_4 = models.IntegerField(default=0)
    articles_revised_by_me_level_5 = models.IntegerField(default=0)
    articles_published_be_me_level_1 = models.IntegerField(default=0)
    articles_published_be_me_level_2 = models.IntegerField(default=0)
    articles_published_be_me_level_3 = models.IntegerField(default=0)
    articles_published_be_me_level_4 = models.IntegerField(default=0)
    articles_published_be_me_level_5 = models.IntegerField(default=0)


#score needed to achieve badges
class UserScore(models.Model):
    author = models.IntegerField(default=0)
    publisher = models.IntegerField(default=0)
    role_score = models.CharField(max_length=20, default='role_score')

class FlagReason(models.Model):
    reason = models.CharField(max_length=200)

    def __str__(self):
        return self.reason

#it will store score of a particular article
class ArticleScoreLog(models.Model):
    resource = models.OneToOneField(Articles ,on_delete = models.CASCADE)
    upvote = models.IntegerField(null = True, default=0)
    downvote = models.IntegerField(null = True, default=0)
    reported = models.IntegerField(null = True, default=0)
    publish = models.BooleanField(default=False)

class ArticleUserScoreLogs(models.Model):
    user = models.ForeignKey(User ,on_delete = models.CASCADE)
    resource = models.ForeignKey(Articles ,on_delete = models.CASCADE)
    upvoted = models.BooleanField(default=False)
    downvoted = models.BooleanField(default=False)
    reported = models.BooleanField(default=False)

class ArticleFlagLogs(models.Model):
    resource = models.ForeignKey(Articles, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    reason = models.ForeignKey(FlagReason, on_delete=models.CASCADE)

class MediaScoreLog(models.Model):
    resource = models.OneToOneField(Media ,on_delete = models.CASCADE)
    upvote = models.IntegerField(null = True, default=0)
    downvote = models.IntegerField(null = True, default=0)
    reported = models.IntegerField(null = True, default=0)
    publish = models.BooleanField(default=False)

class MediaUserScoreLogs(models.Model):
    user = models.ForeignKey(User ,on_delete = models.CASCADE)
    resource = models.ForeignKey(Media ,on_delete = models.CASCADE)
    upvoted = models.BooleanField(default=False)
    downvoted = models.BooleanField(default=False)
    reported = models.BooleanField(default=False)

class MediaFlagLogs(models.Model):
    resource = models.ForeignKey(Media, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    reason = models.ForeignKey(FlagReason, on_delete=models.CASCADE)

from .meta_badges import *