from badges.utils import MetaBadge
from .models import CommunityReputaion
from badges.utils import register as register_badge
from BasicArticle.models import Articles
from Community.models import CommunityArticles

class Publisher(MetaBadge):
    id = 'publisher'
    model = CommunityReputaion
    one_time_only = True

    title = 'Publisher'
    description = 'Awesome publisher!'
    level = '3'

    progress_start = 0
    progress_finish = 1

    def get_user(self, instance):
        return instance.user
    
    def get_community(self, instance):
        return instance.community

    def get_progress(self, community_reputation):
        return 1 if community_reputation.published_count >= 1 else 0 

    def check_published_count(self, instance):
        return instance.published_count > 0

class ContributorBadge(MetaBadge):
    id = 'contributor'
    model = CommunityArticles
    one_time_only = True

    title = 'Contributor'
    description = 'Whoa, a contributor'
    level = '1'

    def get_user(self, instance):
        return instance.user

    def get_community(self, instance):
        return instance.community

    def check_articles_count(self, instance):
        return CommunityArticles.objects.filter(user=instance.user, community=instance.community).count() > 1
