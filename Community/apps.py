from django.apps import AppConfig


class CommunityConfig(AppConfig):
    name = 'Community'

    def ready(self):
        from actstream import registry
        from django.contrib.auth.models import User

        registry.register(User,self.get_model('Community'),self.get_model('CommunityMembership'))
