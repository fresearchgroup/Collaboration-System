from django.shortcuts import render
from Community.models import CommunityArticles
from actstream import action
from actstream.models import Action
from django.contrib.contenttypes.models import ContentType

# Create your views here.

def create_article_feed(actor,verb,action_object):
        article = actor
        article_community = CommunityArticles.objects.get(article=article)
        #actor_href = ""
        if verb=="Article is available for editing":
                actor_href='article_edit'
        elif verb=="Article has been published":
                actor_href='article_view'
        action.send(article,verb=verb,action_object=action_object,target=article_community.community,actor_href=actor_href,actor_href_id=article.id,action_object_href='display_user_profile',action_object_href_id=action_object.username)

 
def create_community_feed(actor,verb,target):
        user = actor
        action.send(user, verb=verb,target=target, actor_href='display_user_profile', actor_href_id=user.username) 
        
def delete_feeds(actor,verb):
        Action.objects.filter(actor_object_id=actor.id,actor_content_type=ContentType.objects.get_for_model(actor),verb=verb).delete()      
