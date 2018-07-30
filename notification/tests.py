import json
import pytz
from django.conf import settings
from django.contrib.auth.models import User
from django.test import RequestFactory, TestCase
from django.utils import timezone
from django.utils.timezone import localtime, utc
from notifications.models import Notification, notify_handler
from notifications.signals import notify
from django.test import override_settings  # noqa
from django.urls import reverse
from Community.models import Community, CommunityArticles, CommunityMembership, CommunityGroups
from Group.models import Group, GroupArticles, GroupMembership
from BasicArticle.models import Articles
from django.contrib.auth.models import Group as Roles
from . import views
from django.contrib.contenttypes.models import ContentType
from workflow.models import States

class NotificationManagersTest(TestCase):
    def setUp(self):
        self.message_count = 10
        self.user1 = User.objects.create(username="user1", password="pwd", email="example@example.com")
        self.user2 = User.objects.create(username="user2", password="pwd", email="example@example.com")
        self.user3 = User.objects.create(username="user3", password="pwd", email="example@example.com")
        self.comm = Community.objects.create(name='fake_community', desc='fake',
                                             image='/home/bharat/Pictures/einstein.jpeg',
                                             category='fake', created_by=self.user1, tag_line='always fake',
                                             forum_link='jvajds')

        self.grp = Group.objects.create(name='fake_grp', desc='I am fake', image='/home/bharat/Pictures/einstein.jpeg',
                                        visibility=True, created_by=self.user1)

        self.author_role = Roles.objects.create(name='author')
        self.publisher_role = Roles.objects.create(name='publisher')
        self.comm_admin = Roles.objects.create(name='community_admin')
        self.grp_admin = Roles.objects.create(name='group_admin')

        self.c_author = CommunityMembership.objects.create(user=self.user1, community=self.comm, role=self.author_role)
        self.c_publisher = CommunityMembership.objects.create(user=self.user2, community=self.comm,
                                                            role=self.publisher_role)
        self.community_admin = CommunityMembership.objects.create(user=self.user3, community=self.comm, role=self.comm_admin)

        self.g_author = GroupMembership.objects.create(user=self.user1, group=self.grp, role=self.author_role)
        self.g_publisher = GroupMembership.objects.create(user=self.user2, group=self.grp,
                                                            role=self.publisher_role)
        self.group_admin = GroupMembership.objects.create(user=self.user3, group=self.grp, role=self.grp_admin)

        self.commgrp = CommunityGroups.objects.create(group=self.grp, user=self.user3, community=self.comm)

        self.draft=States.objects.create(name='draft')
        self.private = States.objects.create(name='private')
        self.visible=States.objects.create(name='visible')
        self.publishable=States.objects.create(name='publishable')
        self.publish=States.objects.create(name='publish')

        self.article1 = Articles.objects.create(title='fake_article1', body='abc', created_by=self.user1, state=self.draft)
        self.article2 = Articles.objects.create(title='fake_article2', body='xyz', created_by=self.user1, state=self.draft)

        self.comm_article = CommunityArticles.objects.create(article=self.article1, community=self.comm, user=self.user1)
        self.group_article = GroupArticles.objects.create(article=self.article2, group=self.grp, user=self.user1)


    def test_notify_subscribe_unsubscribe(self):
        views.notify_subscribe_unsubscribe(self.user1, self.comm, 'subscribe')
        notification = Notification.objects.get(pk=1)
        self.assertEqual(notification.verb, 'Welcome to the community')
        self.assertEqual(notification.actor, self.user1)
        self.assertEqual(notification.recipient, self.user1)

        views.notify_subscribe_unsubscribe(self.user1, self.comm, 'unsubscribe')
        notification = Notification.objects.get(pk=2)
        self.assertEqual(notification.verb, 'You have successfully unsubscribed from the community and can no longer contribute. Your earlier contributions to the community will remain.')
        self.assertEqual(notification.actor, self.user1)
        self.assertEqual(notification.recipient, self.user1)

        views.notify_subscribe_unsubscribe(self.user1, self.grp, 'subscribe')
        notification = Notification.objects.get(pk=3)
        self.assertEqual(notification.verb, 'Welcome to the group')
        self.assertEqual(notification.actor, self.user1)
        self.assertEqual(notification.recipient, self.user1)

        views.notify_subscribe_unsubscribe(self.user1, self.grp, 'unsubscribe')
        notification = Notification.objects.get(pk=4)
        self.assertEqual(notification.verb, 'You have successfully unsubscribed from the group and can no longer contribute. Your earlier contributions to the group will remain.')
        self.assertEqual(notification.actor, self.user1)
        self.assertEqual(notification.recipient, self.user1)

    def test_publishable_article_state_for_community(self):
        self.article1.state=self.publishable
        views.notify_update_article_state(self.user1, self.article1, 'publishable')
        notifications = Notification.objects.all()
        for notification in notifications:
            self.assertEqual(notification.verb, 'This article is publishable')

    '''def test_published_article_state_for_community(self):
        self.article1.state=self.publish
        views.notify_update_article_state(self.user2, self.article1, 'published')
        notification = Notification.objects.get(pk=1)
        self.assertEqual(notification.verb, 'Your article is published')
        notification = Notification.objects.get(pk=2)
        self.assertEqual(notification.verb, 'This article is published')
        notification = Notification.objects.get(pk=3)
        self.assertEqual(notification.verb, 'This article is published')'''

    def test_private_article_state_for_group(self):
        self.article2.state=self.visible
        views.notify_update_article_state(self.user1, self.article2, 'private')
        notifications = Notification.objects.all()
        for notification in notifications:
            self.assertEqual(notification.verb, 'Article is available for editing to group members')

    def test_visible_article_state_for_group(self):
        self.article2.state = self.visible
        views.notify_update_article_state(self.user2, self.article2, 'visible')
        notifications = Notification.objects.all()
        for notification in notifications:
            self.assertEqual(notification.verb, 'This group article can be published')

    '''def test_publish_article_state_for_group(self):
        self.article2.state = self.visible
        views.notify_update_article_state(self.user2, self.article2, 'published')
        notification = Notification.objects.get(pk=1)
        self.assertEqual(notification.verb, 'Your article is published')
        notification = Notification.objects.get(pk=2)
        self.assertEqual(notification.verb, 'This article is published')
        notification = Notification.objects.get(pk=3)
        self.assertEqual(notification.verb, 'This article is published')'''

    '''def test_private_state_for_rejected_article_for_group(self):
        self.article2.state = self.private
        views.notify_update_article_state(self.user2, self.article2, 'rejected')
        notification = Notification.objects.get(pk=1)
        self.assertEqual(notification.verb, 'Your article got rejected')
        notification = Notification.objects.get(pk=2)
        self.assertEqual(notification.verb, 'This article got rejected')
        notification = Notification.objects.get(pk=3)
        self.assertEqual(notification.verb, 'This article got rejected')'''