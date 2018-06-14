from django.shortcuts import render
from Community.models import CommunityArticles
from actstream import action
from actstream.models import Action
from django.contrib.contenttypes.models import ContentType
from BasicArticle.models import Articles

# Create your views here.


def create_resource_feed(actor,verb,action_object):
        if isinstance(actor, Articles):
                target = CommunityArticles.objects.get(article=actor).community
        
                if verb=="Article is available for editing":
                        actor_href='article_edit'
                elif verb=="Article has been published" or verb=="This article is no more available for editing":
                        actor_href='article_view'
        action.send(actor,verb=verb,action_object=action_object,target=target,actor_href=actor_href,actor_href_id=actor.id,action_object_href='display_user_profile',action_object_href_id=action_object.username)

 
def create_community_feed(actor,verb,target):
        action.send(actor, verb=verb,target=target, actor_href='display_user_profile', actor_href_id=actor.username) 
        

