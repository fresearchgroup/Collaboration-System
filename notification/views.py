from Community.models import CommunityArticles, CommunityMembership, CommunityGroups
from Group.models import GroupArticles, GroupMembership
from django.contrib.auth.models import Group as Roles
from notifications.signals import notify

def notify_community_subscribe_unsubscribe(user, community, verb):
    notify.send(sender=user, recipient=user,
                verb=verb, target=community, target_url="community_view", sender_url="display_user_profile", sender_url_name=user.username )

def notify_update_article_state(user, article, action):
    if CommunityArticles.objects.filter(article=article).exists():
        comm = CommunityArticles.objects.get(article=article)

        publisher_role = Roles.objects.get(name='publisher')
        admin_role = Roles.objects.get(name='community_admin')

        admins = CommunityMembership.objects.filter(community=comm.community, role=admin_role)
        publishers = CommunityMembership.objects.filter(community=comm.community, role=publisher_role)

        list = []
        for publisher in publishers:
            if article.created_by != publisher.user:
                list.append(publisher.user)

        for admin in admins:
            if article.created_by != admin.user:
                list.append(admin.user)

        if action == 'publishable':
            notify.send(sender=user, recipient=list,
                        verb='This article is publishable', target=article,
                        target_url="article_edit", sender_url="display_user_profile", sender_url_name=user.username)

        elif action == 'published':
            notify.send(sender=user, recipient=list,
                        verb='This article is published', target=article,
                        target_url="article_view", sender_url="display_user_profile", sender_url_name=user.username)

            notify.send(sender=user, recipient=article.created_by,
                        verb='Your article is published', target=article,
                        target_url="article_view", sender_url="display_user_profile", sender_url_name=user.username)

    elif GroupArticles.objects.filter(article=article).exists():
        grp = GroupArticles.objects.get(article=article)

        publisher_role = Roles.objects.get(name='publisher')

        if action=='visible' or action=='published':

            admin_role = Roles.objects.get(name='community_admin')
            comm = CommunityGroups.objects.get(group=grp.group)
            admins = CommunityMembership.objects.filter(community=comm.community, role=admin_role)
            publishers = CommunityMembership.objects.filter(community=comm.community, role=publisher_role)

        else:
            admin_role = Roles.objects.get(name='group_admin')
            publishers = GroupMembership.objects.filter(group=grp.group, role=publisher_role)
            admins = GroupMembership.objects.filter(group=grp.group, role=admin_role)

        list = []
        for publisher in publishers:
            if article.created_by != publisher.user:
                list.append(publisher.user)

        for admin in admins:
            if article.created_by != admin.user:
                list.append(admin.user)

        if action=='private':
            notify.send(sender=user, recipient=list,
                        verb='This group article is in private state, can be changed to visible', target=article,
                        target_url="article_edit", sender_url="display_user_profile", sender_url_name=user.username)

        elif action == 'visible':
            notify.send(sender=user, recipient=list,
                        verb='This group article can be published', target=article,
                        target_url="article_edit", sender_url="display_user_profile", sender_url_name=user.username)

        elif action == 'published' or action=='rejected':
            verb1=''
            verb2=''
            if action== 'published':
                verb1='This article is published'
                verb2='Your article is published'
            elif action=='rejected':
                verb1='This article got rejected'
                verb2='Your article got rejected'


            notify.send(sender=user, recipient=list,
                        verb=verb1, target=article,
                        target_url="article_view", sender_url="display_user_profile", sender_url_name=user.username)

            notify.send(sender=user, recipient=article.created_by,
                        verb=verb2, target=article,
                        target_url="article_view", sender_url="display_user_profile", sender_url_name=user.username)


def notify_update_role(sender, user, target, current_role):
    membership = CommunityMembership.objects.get(user=user, community=target.pk)
    previous_role = membership.role.name
    if current_role == 'publisher':
        if previous_role == 'author':
            notify.send(sender=sender, verb='Your role has been changed from Author to Publisher', recipient=user, target=target,
                        target_url="community_view", sender_url='display_user_profile', sender_url_name=sender.username)
        elif previous_role == 'community_admin':
            notify.send(sender=sender, verb='Your role has been changed from Admin to Publisher', recipient=user,
                        target=target,
                        target_url="community_view", sender_url='display_user_profile', sender_url_name=sender.username)

    elif current_role == 'author':
        if previous_role == 'publisher':
            notify.send(sender=sender, verb='Your role has been changed from Publisher to Author', recipient=user,
                        target=target,
                        target_url="community_view", sender_url='display_user_profile', sender_url_name=sender.username)

        elif previous_role == 'community_admin':
            notify.send(sender=sender, verb='Your role has been changed from Admin to Author', recipient=user,
                        target=target,
                        target_url="community_view", sender_url='display_user_profile', sender_url_name=sender.username)

    elif current_role == 'community_admin':
        if previous_role == 'publisher':
            notify.send(sender=sender, verb='Your role has been changed from Publisher to Admin', recipient=user,
                        target=target,
                        target_url="community_view", sender_url='display_user_profile', sender_url_name=sender.username)

        elif previous_role == 'author':
            notify.send(sender=sender, verb='Your role has been changed from Author to Admin', recipient=user,
                        target=target,
                        target_url="community_view", sender_url='display_user_profile', sender_url_name=sender.username)


def notify_remove_or_add_user(sender, user, target, action_type):
    if action_type == 'community_created':
        notify.send(sender=sender, verb='Your are now an admin', recipient=user,
                    target=target,
                    target_url="community_view", sender_url='display_user_profile', sender_url_name=sender.username)
    else:
        membership = CommunityMembership.objects.get(user=user, community=target.pk)
        previous_role = membership.role.name
        if previous_role == 'publisher':
            if action_type == 'removed':
                notify.send(sender=sender, verb='Your have been removed as a publisher', recipient=user,
                            target=target,
                            target_url="community_view", sender_url='display_user_profile',
                            sender_url_name=sender.username)
            elif action_type == 'left':
                notify.send(sender=sender, verb='You left the community as a publisher', recipient=user,
                            target=target,
                            target_url="community_view", sender_url='display_user_profile',
                            sender_url_name=sender.username)

        elif previous_role == 'community_admin':
            if action_type == 'removed':
                notify.send(sender=sender, verb='You have been removed from community as admin', recipient=user,
                            target=target,
                            target_url="community_view", sender_url='display_user_profile',
                            sender_url_name=sender.username)
            elif action_type == 'left':
                notify.send(sender=sender, verb='Your left the community as admin', recipient=user,
                            target=target,
                            target_url="community_view", sender_url='display_user_profile',
                            sender_url_name=sender.username)

        elif previous_role == 'author':
            if action_type == 'removed':
                notify.send(sender=sender, verb='You have been removed from community', recipient=user,
                            target=target,
                            target_url="community_view", sender_url='display_user_profile',
                            sender_url_name=sender.username)

def notify_edit_article(user, article):
    verb=""
    role=""
    if CommunityArticles.objects.filter(article=article).exists():
        comm = CommunityArticles.objects.get(article=article)
        membership = CommunityMembership.objects.get(user=user, community=comm.community.pk)
        role = membership.role.name
        if(role=="community_admin"):
            verb="Admin edited your article"

    else:
        grp = GroupArticles.objects.get(article=article)
        membership = GroupMembership.objects.get(user=user, group=grp.group.pk)
        role = membership.role.name
        if role == 'publisher':
            verb="Group publisher edited your article"
        elif (role == "group_admin"):
            verb = "Group admin edited your article"

    if role == 'author':
        verb="Your article got edited"

    notify.send(sender=user, verb=verb, recipient=article.created_by,
                target=article,
                target_url="article_view", sender_url='display_user_profile',
                sender_url_name=user.username)
