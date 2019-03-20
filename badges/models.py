from __future__ import unicode_literals
from datetime import datetime

from django.contrib.auth import get_user_model
try:
    from django.urls import reverse
except ImportError:
    from django.core.urlresolvers import reverse
from django.db import models
from django.conf import settings

from badges.signals import badge_awarded
from badges.managers import BadgeManager

from Community.models import Community

if hasattr(settings, 'BADGE_LEVEL_CHOICES'):
    LEVEL_CHOICES = settings.BADGE_LEVEL_CHOICES
else:
    LEVEL_CHOICES = (
        ("1", "Bronze"),
        ("2", "Silver"),
        ("3", "Gold"),
        ("4", "Diamond"),
    )

class Badge(models.Model):
    id = models.CharField(max_length=255, primary_key=True)
    user = models.ManyToManyField(settings.AUTH_USER_MODEL, related_name="badges", through='BadgeToUser')
    level = models.CharField(max_length=1, choices=LEVEL_CHOICES)

    icon = models.ImageField(upload_to='badge_images')

    objects = BadgeManager()

    @property
    def meta_badge(self):
        from .utils import registered_badges
        return registered_badges[self.id]

    @property
    def title(self):
        return str(self.meta_badge.title)

    @property
    def description(self):
        return self.meta_badge.description

    def __unicode__(self):
        return "%s" % self.title

    def __str__(self):
        return self.title

    def get_absolute_url(self):
        return reverse('badge_detail', kwargs={'slug': self.id})

    def award_to(self, user, community):
        has_badge = self in user.badges.all()
        
        if self.meta_badge.one_time_only and has_badge:
            if BadgeToUser.objects.filter(badge=self, user=user, community=community).count() > 0:
                return False

        BadgeToUser.objects.create(badge=self, user=user, community=community)

        badge_awarded.send(sender=self.meta_badge, user=user, badge=self)

        return BadgeToUser.objects.filter(badge=self, user=user).count()

    def number_awarded(self, user_or_qs=None):
        """
        Gives the number awarded total. Pass in an argument to
        get the number per user, or per queryset.
        """
        kwargs = {'badge':self}
        if user_or_qs is None:
            pass
        elif isinstance(user_or_qs, get_user_model()):
            kwargs.update(dict(user=user_or_qs))
        else:
            kwargs.update(dict(user__in=user_or_qs))
        return BadgeToUser.objects.filter(**kwargs).count()


class BadgeToUser(models.Model):
    badge = models.ForeignKey(Badge, on_delete=models.CASCADE)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)

    created = models.DateTimeField(default=datetime.now)
    community = models.ForeignKey(Community, on_delete=models.CASCADE)


from . import listeners
