from django.apps import AppConfig


class GroupConfig(AppConfig):
    name = 'Group'

    def ready(self):
        from actstream import registry
        from django.contrib.auth.models import User

        registry.register(User, self.get_model('Group'), self.get_model('GroupMembership'))
