from django.apps import AppConfig


class BasicarticleConfig(AppConfig):
    name = 'BasicArticle'
    
    def ready(self):
        from actstream import registry
        from django.contrib.auth.models import User

        registry.register(User,self.get_model('Articles'))
