from django.shortcuts import render
from Community.models import CommunityArticles, Community, CommunityMembership, CommunityGroups
from actstream import action
from actstream.models import Action
from django.contrib.contenttypes.models import ContentType
from BasicArticle.models import Articles
from Group.models import GroupArticles
# Create your views here.


def create_resource_feed(actor,verb_id,action_object):
	if isinstance(actor, Articles):
		verb=''
		if CommunityArticles.objects.filter(article=actor).exists():
			target = CommunityArticles.objects.get(article=actor).community
			if verb_id=="article_published" :
				verb="Article has been published"
				actor_href='article_view'

		else:
			target = GroupArticles.objects.get(article=actor).group
			if verb_id=="article_published" :
				verb="Group article has been published"
				actor_href='article_view'
				comm=CommunityGroups.objects.get(group=target)
				target=comm.community

		if verb_id == 'article_edit':
			verb="Article is available for editing"
			actor_href = 'article_edit'

		if verb_id=='article_no_edit':
			verb = "This article is no more available for editing"
			actor_href = 'article_view'

		action.send(actor,verb=verb,action_object=action_object,target=target,actor_href=actor_href,actor_href_id=actor.id,action_object_href='display_user_profile',action_object_href_id=action_object.username)

 
def update_role_feed(user,target,current_role):
	membership = CommunityMembership.objects.get(user =user, community = target.pk)
	previous_role = membership.role.name
	if current_role=='publisher':
		if previous_role=='author':
			action.send(user, verb='Role changed from Author to Publisher',target=target, actor_href='display_user_profile', actor_href_id=user.username) 
		elif previous_role=='community_admin':
			action.send(user, verb='Role changed from Admin to Publisher',target=target, actor_href='display_user_profile', actor_href_id=user.username) 
			
	elif current_role=='author':
		if previous_role=='publisher':
			action.send(user, verb='Role changed from Publisher to Author',target=target, actor_href='display_user_profile', actor_href_id=user.username) 
		elif previous_role=='community_admin':
			action.send(user, verb='Role changed from Admin to Author',target=target, actor_href='display_user_profile', actor_href_id=user.username) 

	elif current_role=='community_admin':
		if previous_role=='publisher':
			action.send(user, verb='Role changed from Publisher to Admin',target=target, actor_href='display_user_profile', actor_href_id=user.username) 
		elif previous_role=='author':
			action.send(user, verb='Role changed from Author to Admin',target=target, actor_href='display_user_profile', actor_href_id=user.username) 

def remove_or_add_user_feed(user,target,action_type):
	if action_type=='community_created':
		action.send(user, verb='Admin has been added to the community',target=target, actor_href='display_user_profile', actor_href_id=user.username)
	else:
		membership = CommunityMembership.objects.get(user =user, community = target.pk)
		previous_role = membership.role.name
		if previous_role=='publisher':
			if action_type=='removed':
				action.send(user, verb='Publisher has been removed from community',target=target, actor_href='display_user_profile', actor_href_id=user.username)
			elif action_type=='left':
				action.send(user, verb='Publisher has left the community',target=target, actor_href='display_user_profile', actor_href_id=user.username)

		elif previous_role=='community_admin':
			if action_type=='removed':
				action.send(user, verb='Admin has been removed from community',target=target, actor_href='display_user_profile', actor_href_id=user.username)
			elif action_type=='left':
				action.send(user, verb='Admin has left the community',target=target, actor_href='display_user_profile', actor_href_id=user.username)
