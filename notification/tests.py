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

from Community.models import Community
from Group.models import Group
from . import views
from django.contrib.contenttypes.models import ContentType

class NotificationManagersTest(TestCase):
    ''' Django notifications Manager automated tests '''
    def setUp(self):
        self.message_count = 10
        self.other_user = User.objects.create(username="other1", password="pwd", email="example@example.com")

        self.from_user = User.objects.create(username="from2", password="pwd", email="example@example.com")
        self.to_user = User.objects.create(username="to2", password="pwd", email="example@example.com")

        self.comm = Community.objects.create(name='fake_community', desc='fake', image='/home/bharat/Pictures/einstein.jpeg',
                                 category='fake',created_by=self.other_user, tag_line='always fake', forum_link='jvajds')

        self.grp = Group.objects.create(name='fake_grp', desc='I am fake', image='/home/bharat/Pictures/einstein.jpeg', visibility=True, created_by=self.other_user)


    def test_notify_subscribe_unsubscribe(self):

            views.notify_subscribe_unsubscribe(self.other_user, self.comm, 'subscribe')
            notification = Notification.objects.get(pk=1)
            self.assertEqual(notification.verb, 'Welcome to the community')
            self.assertEqual(notification.actor, self.other_user)
            self.assertEqual(notification.recipient, self.other_user)

            views.notify_subscribe_unsubscribe(self.other_user, self.comm, 'unsubscribe')
            notification = Notification.objects.get(pk=2)
            self.assertEqual(notification.verb, 'You left the community')
            self.assertEqual(notification.actor, self.other_user)
            self.assertEqual(notification.recipient, self.other_user)

            views.notify_subscribe_unsubscribe(self.other_user, self.grp, 'subscribe')
            notification = Notification.objects.get(pk=3)
            self.assertEqual(notification.verb, 'Welcome to the group')
            self.assertEqual(notification.actor, self.other_user)
            self.assertEqual(notification.recipient, self.other_user)

            views.notify_subscribe_unsubscribe(self.other_user, self.grp, 'unsubscribe')
            notification = Notification.objects.get(pk=4)
            self.assertEqual(notification.verb, 'You left the group')
            self.assertEqual(notification.actor, self.other_user)
            self.assertEqual(notification.recipient, self.other_user)


