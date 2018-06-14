from Community.models import CommunityArticles, CommunityMembership, CommunityGroups
from Group.models import GroupArticles, GroupMembership
from django.contrib.auth.models import Group as Roles
from notifications.signals import notify

def notif_community_subscribe_unsubscribe(user, community, verb):
    notify.send(sender=user, recipient=user,
                verb=verb, target=community, target_url="community_view", sender_url="display_user_profile", sender_url_name=user.username )

def notif_publishable_article(user,article):
    comm = CommunityArticles.objects.get(article=article)
    publisher_role = Roles.objects.get(name='publisher')
    publishers = CommunityMembership.objects.filter(community=comm.community, role=publisher_role)
    list = []
    for publisher in publishers:
        if article.created_by != publisher.user:
            list.append(publisher.user)

    admin_role = Roles.objects.get(name='community_admin')
    admins = CommunityMembership.objects.filter(community=comm.community, role=admin_role)

    for admin in admins:
        if article.created_by != admin.user:
            list.append(admin.user)

    notify.send(sender=user, recipient=list,
                verb='This article is publishable', target=article,
                target_url="article_edit", sender_url="display_user_profile", sender_url_name=user.username)

def notify_published_article(user, article):
    comm = CommunityArticles.objects.get(article=article)
    publisher_role = Roles.objects.get(name='publisher')
    publishers = CommunityMembership.objects.filter(community=comm.community, role=publisher_role)
    list = []
    for publisher in publishers:
        if article.created_by != publisher.user:
            list.append(publisher.user)

    admin_role = Roles.objects.get(name='community_admin')
    admins = CommunityMembership.objects.filter(community=comm.community, role=admin_role)

    for admin in admins:
        if article.created_by != admin.user:
            list.append(admin.user)

    notify.send(sender=user, recipient=list,
                verb='This article is published', target=article,
                target_url="article_view", sender_url="display_user_profile", sender_url_name=user.username)

    notify.send(sender=user, recipient=article.created_by,
                verb='Your article is published', target=article,
                target_url="article_view", sender_url="display_user_profile", sender_url_name=user.username)
