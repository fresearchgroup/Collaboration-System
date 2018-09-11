from django.db import models
from Community.models import Community
from Group.models import Group
from BasicArticle.models import Articles
from django.contrib.auth.models import User

class EtherCommunity(models.Model):
    community = models.ForeignKey(Community, related_name='ether_community')
    community_ether_id = models.TextField()

class EtherGroup(models.Model):
    group = models.ForeignKey(Group, related_name='ether_group')
    group_ether_id = models.TextField()

class EtherArticle(models.Model):
    article = models.ForeignKey(Articles, related_name='ether_article')
    article_ether_id = models.TextField()

class EtherUser(models.Model):
    user = models.ForeignKey(User, related_name='ether_user')
    user_ether_id = models.TextField()
