from badges.utils import MetaBadge
from .models import CommunityReputaion
from badges.utils import register as register_badge
from BasicArticle.models import Articles
from Community.models import CommunityArticles
from Reputation.models import UserScore

class Publisher(MetaBadge):
    id = 'publisher'
    model = CommunityReputaion
    one_time_only = True

    title = 'Publisher'
    description = 'Awesome publisher!'
    level = '3'

    user_score = UserScore.objects.get_or_create(role_score='role_score')[0]

    progress_start = 0
    progress_finish = user_score.publisher

    def get_user(self, instance):
        return instance.user
    
    def get_community(self, instance):
        return instance.community

    def get_progress(self, user, community):
        community_reputation = CommunityReputaion.objects.get(user=user, community=community)
        score = community_reputation.get_reputation_score()

        return self.user_score.publisher if score > self.user_score.publisher else score

    def check_published_count(self, instance):
        instance.refresh_from_db()
        
        return instance.get_reputation_score() > self.user_score.publisher

class Author(MetaBadge):
    id = 'author'
    model = CommunityReputaion
    one_time_only = True

    title = 'Author'
    description = 'Awesome author!'
    level = '3'

    user_score = UserScore.objects.get_or_create(role_score='role_score')[0]

    progress_start = 0
    progress_finish = user_score.author

    def get_user(self, instance):
        return instance.user
    
    def get_community(self, instance):
        return instance.community

    def get_progress(self, user, community):
        community_reputation = CommunityReputaion.objects.get(user=user, community=community)
        score = community_reputation.get_reputation_score()

        return self.user_score.author if score > self.user_score.author else score

    def check_published_count(self, instance):
        instance.refresh_from_db()
        
        return instance.get_reputation_score() > self.user_score.author

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
