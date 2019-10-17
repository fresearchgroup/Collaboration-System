from Community.models import CommunityArticles, CommunityMembership, CommunityGroups, Community, CommunityCourses,CommunityMedia
from Group.models import GroupArticles, GroupMembership, Group
from django.contrib.auth.models import Group as Roles
from notifications.signals import notify

def notify_subscribe_unsubscribe(user, target, type):
    verb=''
    target_url=''
    if isinstance(target, Community):
        target_url="community_view"
        if type == 'subscribe':
            verb='Welcome to the community'
        elif type == 'unsubscribe':
            verb = 'You have successfully unsubscribed from the community and can no longer contribute. Your earlier contributions to the community will remain.'
    elif isinstance(target, Group):
        target_url="group_view"
        if type == 'subscribe':
            verb = 'Welcome to the group'
        elif type == 'unsubscribe':
            verb = 'You have successfully unsubscribed from the group and can no longer contribute. Your earlier contributions to the group will remain.'

    notify.send(sender=user, recipient=user,
                verb=verb, target=target, target_url=target_url, sender_url="display_user_profile", sender_url_name=user.username )

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
            notify.send(sender=user, recipient=article.created_by,
                        verb='Your article is published', target=article,
                        target_url="article_view", sender_url="display_user_profile", sender_url_name=user.username)

            notify.send(sender=user, recipient=list,
                        verb='This article is published', target=article,
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
                        verb='Article is available for editing to group members', target=article,
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

            notify.send(sender=user, recipient=article.created_by,
                        verb=verb2, target=article,
                        target_url="article_view", sender_url="display_user_profile", sender_url_name=user.username)

            notify.send(sender=user, recipient=list,
                        verb=verb1, target=article,
                        target_url="article_view", sender_url="display_user_profile", sender_url_name=user.username)


def notify_update_role(sender, user, target, current_role):
    target_url=''
    previous_role=''

    if isinstance(target, Community) and CommunityMembership.objects.filter(user=user, community=target).exists():
        membership = CommunityMembership.objects.get(user=user, community=target.pk)
        target_url="community_view"
        previous_role = membership.role.name

    elif GroupMembership.objects.filter(user=user, group=target).exists():
        membership = GroupMembership.objects.get(user=user, group=target.pk)
        target_url = "group_view"
        previous_role = membership.role.name

    if current_role == 'publisher':
        if previous_role == 'author':
            notify.send(sender=sender, verb='Congratulations! Your role has been upgraded from Author to Publisher', recipient=user, target=target,
                        target_url=target_url, sender_url='display_user_profile', sender_url_name=sender.username)
        elif previous_role == 'community_admin' or previous_role == 'group_admin' :
            notify.send(sender=sender, verb='Your role has been changed from Admin to Publisher', recipient=user,
                        target=target,
                        target_url=target_url, sender_url='display_user_profile', sender_url_name=sender.username)

    elif current_role == 'author':
        if previous_role == 'publisher':
            notify.send(sender=sender, verb='Your role has been changed from Publisher to Author', recipient=user,
                        target=target,
                        target_url=target_url, sender_url='display_user_profile', sender_url_name=sender.username)

        elif previous_role == 'community_admin' or previous_role == 'group_admin':
            notify.send(sender=sender, verb='Your role has been changed from Admin to Author', recipient=user,
                        target=target,
                        target_url=target_url, sender_url='display_user_profile', sender_url_name=sender.username)

    elif current_role == 'community_admin' or current_role == 'group_admin':
        if previous_role == 'publisher':
            notify.send(sender=sender, verb='Congratulations! Your role has been upgraded from Publisher to Admin', recipient=user,
                        target=target,
                        target_url=target_url, sender_url='display_user_profile', sender_url_name=sender.username)

        elif previous_role == 'author':
            notify.send(sender=sender, verb='Congratulations! Your role has been upgraded from Author to Admin', recipient=user,
                        target=target,
                        target_url=target_url, sender_url='display_user_profile', sender_url_name=sender.username)


def notify_remove_or_add_user(sender, user, target, action_type):
    if action_type == 'community_created':
        notify.send(sender=sender, verb='Your are now an admin', recipient=user,
                    target=target,
                    target_url="community_view", sender_url='display_user_profile', sender_url_name=sender.username)
    elif action_type == 'group_created':
        notify.send(sender=sender, verb='Your are now an admin', recipient=user,
                    target=target,
                    target_url="group_view", sender_url='display_user_profile', sender_url_name=sender.username)
    else:
        target_url = ''
        previous_role = ''

        if isinstance(target, Community) and CommunityMembership.objects.filter(user=user, community=target).exists():
            membership = CommunityMembership.objects.get(user=user, community=target.pk)
            target_url = "community_view"
            previous_role = membership.role.name
            place = 'community'

        elif GroupMembership.objects.filter(user=user, group=target).exists():
            membership = GroupMembership.objects.get(user=user, group=target.pk)
            target_url = "group_view"
            previous_role = membership.role.name
            place = 'group'

        assigned_role = previous_role
        if assigned_role == 'community_admin' or assigned_role == 'group_admin':
            assigned_role = 'Admin'

        if action_type == 'added':
            verb = 'You have been added to the ' + place + ' as ' +  assigned_role
            notify.send(sender=sender, verb=verb, recipient=user, target=target,
                        target_url=target_url, sender_url='display_user_profile', sender_url_name=sender.username)

        if previous_role == 'publisher':
            if action_type == 'removed':
                notify.send(sender=sender, verb='You have been removed from the community and can no longer contribute. Your earlier contributions to the community will remain.', recipient=user,
                            target=target,
                            target_url=target_url, sender_url='display_user_profile',
                            sender_url_name=sender.username)
            elif action_type == 'left':
                verb = ''
                if target_url=='community_view' :
                    verb='You have successfully unsubscribed from the community and can no longer contribute. Your earlier contributions to the community will remain.'
                elif target_url=='group_view' :
                    verb = 'You have successfully unsubscribed from the group and can no longer contribute. Your earlier contributions to the group will remain.'
                notify.send(sender=sender, verb=verb, recipient=user,
                            target=target,
                            target_url=target_url, sender_url='display_user_profile',
                            sender_url_name=sender.username)

        elif previous_role == 'community_admin' or previous_role == 'group_admin':
            if action_type == 'removed':
                verb=''
                if target_url == 'community_view':
                    if sender == user:
                        verb='You have successfully unsubscribed from the community and can no longer contribute. Your earlier contributions to the community will remain.'
                    else:
                        verb='You have been removed from the communtiy and can no longer contribute. Your earlier contributions to the community will remain.'
                elif target_url == 'group_view' :
                    if sender == user:
                        verb='You have successfully unsubscribed from the group and can no longer contribute. Your earlier contributions to the group will remain.'
                    else:
                        verb='You have been removed from the group and can no longer contribute. Your earlier contributions to the group will remain.'

                notify.send(sender=sender, verb=verb, recipient=user,
                            target=target,
                            target_url=target_url, sender_url='display_user_profile',
                            sender_url_name=sender.username)
            elif action_type == 'left':
                verb = ''
                if target_url == 'community_view' :
                    verb = "You have successfully unsubscribed the community and can no longer contribute. Your earlier contributions to the community will remain."
                elif target_url == 'group_view' :
                    verb = 'You have successfully unsubscribed from the group and can no longer contribute. Your earlier contributions to the group will remain.'
                notify.send(sender=sender, verb=verb, recipient=user,
                            target=target,
                            target_url=target_url, sender_url='display_user_profile',
                            sender_url_name=sender.username)

        elif previous_role == 'author':
            if action_type == 'removed':
                verb = ''
                if target_url == 'community_view' :
                    verb = 'You have been removed from the community and can no longer contribute. Your earlier contributions to the community will remain.'
                elif target_url == 'group_view' :
                    verb = 'You have been removed from the group and can no longer contribute. Your earlier contributions to the group will remain.'
                notify.send(sender=sender, verb=verb, recipient=user,
                            target=target,
                            target_url=target_url, sender_url='display_user_profile',
                            sender_url_name=sender.username)
            elif action_type == 'left':
                verb = ''
                if target_url == 'community_view':
                    verb = 'You have successfully unsubscribed from the community and can no longer contribute. Your earlier contributions to the community will remain.'
                elif target_url == 'group_view':
                    verb = 'You have successfully unsubscribed from the group and can no longer contribute. Your earlier contributions to the group will remain.'
                notify.send(sender=sender, verb=verb, recipient=user,
                            target=target,
                            target_url=target_url, sender_url='display_user_profile',
                            sender_url_name=sender.username)

def notify_edit_article(user, article, current_state):

    if(user != article.created_by):
        verb=""
        role=""
        if CommunityArticles.objects.filter(article=article).exists():
            comm = CommunityArticles.objects.get(article=article)
            membership = CommunityMembership.objects.get(user=user, community=comm.community.pk)
            role = membership.role.name
            if role == 'publisher':
                verb="Publisher edited your article"
            if(role=="community_admin"):
                verb="Admin edited your article"

        else:
            grp = GroupArticles.objects.get(article=article)
            if current_state == 'private' :
                membership = GroupMembership.objects.get(user=user, group=grp.group.pk)
                role = membership.role.name
            elif current_state == 'visible':
                comm = CommunityGroups.objects.get(group=grp.group)
                membership = CommunityMembership.objects.get(user=user, community=comm.community.pk)
                role = membership.role.name

            if role == 'publisher':
                if current_state == 'private' :
                    verb="Group publisher edited your article"
                elif current_state == 'visible' :
                    verb = "Community publisher edited your article"
            elif (role == "group_admin"):
                verb = "Group admin edited your article"
            elif (role == 'community_admin') :
                verb = "Community admin edited your article"

        if role == 'author':
            verb="Your article got edited"

        notify.send(sender=user, verb=verb, recipient=article.created_by,
                    target=article,
                    target_url="article_view", sender_url='display_user_profile',
                    sender_url_name=user.username)

def notify_edit_course(user, course, verb):
    if(user != course.created_by):
        try:
            commcourses = CommunityCourses.objects.get(course=course)
            membership = CommunityMembership.objects.get(user=user, community=commcourses.community.pk)
            sender_rolename = membership.role.name
            notify.send(sender=user, verb=verb, recipient=course.created_by,
                        target=course, target_url="course_view",
                        sender_url='display_user_profile',
                        sender_url_name=user.username,
                        sender_rolename=sender_rolename)
        except CommunityMembership.DoesNotExist:
            errormessage = 'You are not a member of the community'

def notify_update_course_state(user, course, action):
    if CommunityCourses.objects.filter(course=course).exists():
        commcourses = CommunityCourses.objects.get(course=course)
        membership = CommunityMembership.objects.get(user=user, community=commcourses.community.pk)
        sender_rolename = membership.role.name

        comm_admin_list = []
        comm_publisher_list = []
        comm_pub_admin = []
        comm_admin_list = get_comm_list(commcourses.community,'community_admin',course)
        comm_publisher_list = get_comm_list(commcourses.community,'publisher',course)
        comm_pub_admin = comm_admin_list + comm_publisher_list

        if action == 'publishable':
            notify.send(sender=user, recipient=comm_pub_admin,
                        verb='This course has been made publishable', target=course,
                        target_url="course_view", sender_url="display_user_profile",
                        sender_url_name=user.username, sender_rolename=sender_rolename)

        elif action == 'publish':
            notify.send(sender=user, recipient=course.created_by,
                        verb='Your course has been published', target=course,
                        target_url="course_view", sender_url="display_user_profile",
                        sender_url_name=user.username, sender_rolename=sender_rolename)

            notify.send(sender=user, recipient=comm_pub_admin,
                        verb='Course has been published', target=course,
                        target_url="course_view", sender_url="display_user_profile",
                        sender_url_name=user.username, sender_rolename=sender_rolename)

def notify_edit_media(user, media, verb):
    if(user != media.created_by):
        try:
            commmedia = CommunityMedia.objects.get(media=media)
            membership = CommunityMembership.objects.get(user=user, community=commmedia.community.pk)
            sender_rolename = membership.role.name
            notify.send(sender=user, verb=verb, recipient=media.created_by,
                        target=media, target_url="media_view",
                        sender_url='display_user_profile',
                        sender_url_name=user.username,
                        sender_rolename=sender_rolename)
        except CommunityMembership.DoesNotExist:
            errormessage = 'You are not a member of the community'

def notify_update_media_state(user, media, action):
    if CommunityMedia.objects.filter(media=media).exists():
        commmedia = CommunityMedia.objects.get(media=media)
        membership = CommunityMembership.objects.get(user=user, community=commmedia.community.pk)
        sender_rolename = membership.role.name
        comm_admin_list = []
        comm_publisher_list = []
        comm_pub_admin = []
        comm_admin_list = get_comm_list(commmedia.community,'community_admin',media)
        comm_publisher_list = get_comm_list(commmedia.community,'publisher',media)
        comm_pub_admin = comm_admin_list + comm_publisher_list

        if action == 'publishable':
            if commmedia.media.mediatype == 'IMAGE' :
                notify.send(sender=user, recipient=comm_pub_admin,
                        verb='This image has been made publishable', target=media,
                        target_url="media_view", sender_url="display_user_profile",
                        sender_url_name=user.username, sender_rolename=sender_rolename)

        elif action == 'published':
            if commmedia.media.mediatype == 'IMAGE' :
                notify.send(sender=user, recipient=media.created_by,
                        verb='Your image has been published', target=media,
                        target_url="media_view", sender_url="display_user_profile",
                        sender_url_name=user.username, sender_rolename=sender_rolename)

                notify.send(sender=user, recipient=comm_pub_admin,
                        verb='Image has been published', target=media,
                        target_url="media_view", sender_url="display_user_profile",
                        sender_url_name=user.username, sender_rolename=sender_rolename)
        if action == 'publishable':
            if commmedia.media.mediatype == 'AUDIO' :
                notify.send(sender=user, recipient=comm_pub_admin,
                        verb='This audio has been made publishable', target=media,
                        target_url="media_view", sender_url="display_user_profile",
                        sender_url_name=user.username, sender_rolename=sender_rolename)

        elif action == 'published':
            if commmedia.media.mediatype == 'AUDIO' :
                notify.send(sender=user, recipient=media.created_by,
                        verb='Your audio has been published', target=media,
                        target_url="media_view", sender_url="display_user_profile",
                        sender_url_name=user.username, sender_rolename=sender_rolename)

                notify.send(sender=user, recipient=comm_pub_admin,
                        verb='Audio has been published', target=media,
                        target_url="media_view", sender_url="display_user_profile",
                        sender_url_name=user.username, sender_rolename=sender_rolename)
        if action == 'publishable':
            if commmedia.media.mediatype == 'VIDEO' :
                notify.send(sender=user, recipient=comm_pub_admin,
                        verb='This video has been made publishable', target=media,
                        target_url="media_view", sender_url="display_user_profile",
                        sender_url_name=user.username, sender_rolename=sender_rolename)

        elif action == 'published':
            if commmedia.media.mediatype == 'VIDEO' :
                notify.send(sender=user, recipient=media.created_by,
                        verb='Your video has been published', target=media,
                        target_url="media_view", sender_url="display_user_profile",
                        sender_url_name=user.username, sender_rolename=sender_rolename)

                notify.send(sender=user, recipient=comm_pub_admin,
                        verb='Video has been published', target=media,
                        target_url="media_view", sender_url="display_user_profile",
                        sender_url_name=user.username, sender_rolename=sender_rolename)

def get_comm_list(comm, rolename, resource):
    list = []
    role = Roles.objects.get(name=rolename)
    members = CommunityMembership.objects.filter(community=comm, role=role)
    for member in members:
        if resource.created_by != member.user:
            list.append(member.user)
    return list
