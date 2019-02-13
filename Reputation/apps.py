from django.apps import AppConfig
from django.db.models.signals import post_save

class ReputationConfig(AppConfig):
    name = 'Reputation'

    def ready(self):
        from Community.models import CommunityMembership
        from .signals import create_community_reputation
        post_save.connect(create_community_reputation, sender=CommunityMembership, dispatch_uid='create_community_reputation')
