from badges.utils import MetaBadge
from .models import CommunityReputaion, BadgeScore
from badges.utils import register as register_badge
from BasicArticle.models import Articles
from Community.models import CommunityArticles

class ACLevel1(MetaBadge):
    id = 'ac-level-1'
    model = CommunityArticles
    one_time_only = True

    title = 'AC'
    description = 'AC'
    level = '1'
    
    badge_score = BadgeScore.objects.get_or_create()[0]

    progress_start = 0
    progress_finish = badge_score.articles_contributed_level_1

    def get_progress(self, user, community):
        return CommunityArticles.objects.filter(user=user, community=community).count()

    def get_user(self, instance):
        return instance.user

    def get_community(self, instance):
        return instance.community

    def check_articles_count(self, instance):
        return CommunityArticles.objects.filter(user=instance.user, community=instance.community).count() >= self.badge_score.articles_contributed_level_1

class ACLevel2(MetaBadge):
    id = 'ac-level-2'
    model = CommunityArticles
    one_time_only = True

    title = 'AC'
    description = 'AC'
    level = '2'
    
    badge_score = BadgeScore.objects.get_or_create()[0]

    progress_start = 0
    progress_finish = badge_score.articles_contributed_level_2

    def get_progress(self, user, community):
        return CommunityArticles.objects.filter(user=user, community=community).count()

    def get_user(self, instance):
        return instance.user

    def get_community(self, instance):
        return instance.community

    def check_articles_count(self, instance):
        return CommunityArticles.objects.filter(user=instance.user, community=instance.community).count() >= self.badge_score.articles_contributed_level_2

class ACLevel3(MetaBadge):
    id = 'ac-level-3'
    model = CommunityArticles
    one_time_only = True

    title = 'AC'
    description = 'AC'
    level = '3'
    
    badge_score = BadgeScore.objects.get_or_create()[0]

    progress_start = 0
    progress_finish = badge_score.articles_contributed_level_3

    def get_progress(self, user, community):
        return CommunityArticles.objects.filter(user=user, community=community).count()

    def get_user(self, instance):
        return instance.user

    def get_community(self, instance):
        return instance.community

    def check_articles_count(self, instance):
        return CommunityArticles.objects.filter(user=instance.user, community=instance.community).count() >= self.badge_score.articles_contributed_level_3

class ACLevel4(MetaBadge):
    id = 'ac-level-4'
    model = CommunityArticles
    one_time_only = True

    title = 'AC'
    description = 'AC'
    level = '4'
    
    badge_score = BadgeScore.objects.get_or_create()[0]

    progress_start = 0
    progress_finish = badge_score.articles_contributed_level_4

    def get_progress(self, user, community):
        return CommunityArticles.objects.filter(user=user, community=community).count()

    def get_user(self, instance):
        return instance.user

    def get_community(self, instance):
        return instance.community

    def check_articles_count(self, instance):
        return CommunityArticles.objects.filter(user=instance.user, community=instance.community).count() >= self.badge_score.articles_contributed_level_4

class ACLevel5(MetaBadge):
    id = 'ac-level-5'
    model = CommunityArticles
    one_time_only = True

    title = 'AC'
    description = 'AC'
    level = '5'
    
    badge_score = BadgeScore.objects.get_or_create()[0]

    progress_start = 0
    progress_finish = badge_score.articles_contributed_level_5

    def get_progress(self, user, community):
        return CommunityArticles.objects.filter(user=user, community=community).count()

    def get_user(self, instance):
        return instance.user

    def get_community(self, instance):
        return instance.community

    def check_articles_count(self, instance):
        return CommunityArticles.objects.filter(user=instance.user, community=instance.community).count() >= self.badge_score.articles_contributed_level_5

class APLevel1(MetaBadge):
    id = 'ap-level-1'
    model = CommunityReputaion
    one_time_only = True

    title = 'AP'
    description = 'AP'
    level = '1'
    
    badge_score = BadgeScore.objects.get_or_create()[0]

    progress_start = 0
    progress_finish = badge_score.my_articles_published_level_1

    def get_progress(self, user, community):
        return CommunityReputaion.objects.get(user=user, community=community).published_count

    def get_user(self, instance):
        return instance.user

    def get_community(self, instance):
        return instance.community

    def check_my_articles_published_count(self, instance):
        return CommunityReputaion.objects.get(user=instance.user, community=instance.community).published_count >= self.badge_score.my_articles_published_level_1

class APLevel2(MetaBadge):
    id = 'ap-level-2'
    model = CommunityReputaion
    one_time_only = True

    title = 'AP'
    description = 'AP'
    level = '2'
    
    badge_score = BadgeScore.objects.get_or_create()[0]

    progress_start = 0
    progress_finish = badge_score.my_articles_published_level_2

    def get_progress(self, user, community):
        return CommunityReputaion.objects.get(user=user, community=community).published_count

    def get_user(self, instance):
        return instance.user

    def get_community(self, instance):
        return instance.community

    def check_my_articles_published_count(self, instance):
        return CommunityReputaion.objects.get(user=instance.user, community=instance.community).published_count >= self.badge_score.my_articles_published_level_2

class APLevel3(MetaBadge):
    id = 'ap-level-3'
    model = CommunityReputaion
    one_time_only = True

    title = 'AP'
    description = 'AP'
    level = '3'
    
    badge_score = BadgeScore.objects.get_or_create()[0]

    progress_start = 0
    progress_finish = badge_score.my_articles_published_level_3

    def get_progress(self, user, community):
        return CommunityReputaion.objects.get(user=user, community=community).published_count

    def get_user(self, instance):
        return instance.user

    def get_community(self, instance):
        return instance.community

    def check_my_articles_published_count(self, instance):
        return CommunityReputaion.objects.get(user=instance.user, community=instance.community).published_count >= self.badge_score.my_articles_published_level_3

class APLevel4(MetaBadge):
    id = 'ap-level-4'
    model = CommunityReputaion
    one_time_only = True

    title = 'AP'
    description = 'AP'
    level = '4'
    
    badge_score = BadgeScore.objects.get_or_create()[0]

    progress_start = 0
    progress_finish = badge_score.my_articles_published_level_4

    def get_progress(self, user, community):
        return CommunityReputaion.objects.get(user=user, community=community).published_count

    def get_user(self, instance):
        return instance.user

    def get_community(self, instance):
        return instance.community

    def check_my_articles_published_count(self, instance):
        return CommunityReputaion.objects.get(user=instance.user, community=instance.community).published_count >= self.badge_score.my_articles_published_level_4

class APLevel5(MetaBadge):
    id = 'ap-level-5'
    model = CommunityReputaion
    one_time_only = True

    title = 'AP'
    description = 'AP'
    level = '5'
    
    badge_score = BadgeScore.objects.get_or_create()[0]

    progress_start = 0
    progress_finish = badge_score.my_articles_published_level_5

    def get_progress(self, user, community):
        return CommunityReputaion.objects.get(user=user, community=community).published_count

    def get_user(self, instance):
        return instance.user

    def get_community(self, instance):
        return instance.community

    def check_my_articles_published_count(self, instance):
        return CommunityReputaion.objects.get(user=instance.user, community=instance.community).published_count >= self.badge_score.my_articles_published_level_5

class PALevel1(MetaBadge):
    id = 'pa-level-1'
    model = CommunityReputaion
    one_time_only = True

    title = 'PA'
    description = 'PA'
    level = '1'
    
    badge_score = BadgeScore.objects.get_or_create()[0]

    progress_start = 0
    progress_finish = badge_score.articles_published_by_me_level_1

    def get_progress(self, user, community):
        return CommunityReputaion.objects.get(user=user, community=community).published_by_me_count

    def get_user(self, instance):
        return instance.user

    def get_community(self, instance):
        return instance.community

    def check_articles_published_by_me_count(self, instance):
        return CommunityReputaion.objects.get(user=instance.user, community=instance.community).published_by_me_count >= self.badge_score.articles_published_by_me_level_1

class PALevel2(MetaBadge):
    id = 'pa-level-2'
    model = CommunityReputaion
    one_time_only = True

    title = 'PA'
    description = 'PA'
    level = '2'
    
    badge_score = BadgeScore.objects.get_or_create()[0]

    progress_start = 0
    progress_finish = badge_score.articles_published_by_me_level_2

    def get_progress(self, user, community):
        return CommunityReputaion.objects.get(user=user, community=community).published_by_me_count

    def get_user(self, instance):
        return instance.user

    def get_community(self, instance):
        return instance.community

    def check_articles_published_by_me_count(self, instance):
        return CommunityReputaion.objects.get(user=instance.user, community=instance.community).published_by_me_count >= self.badge_score.articles_published_by_me_level_2

class PALevel3(MetaBadge):
    id = 'pa-level-3'
    model = CommunityReputaion
    one_time_only = True

    title = 'PA'
    description = 'PA'
    level = '3'
    
    badge_score = BadgeScore.objects.get_or_create()[0]

    progress_start = 0
    progress_finish = badge_score.articles_published_by_me_level_3

    def get_progress(self, user, community):
        return CommunityReputaion.objects.get(user=user, community=community).published_by_me_count

    def get_user(self, instance):
        return instance.user

    def get_community(self, instance):
        return instance.community

    def check_articles_published_by_me_count(self, instance):
        return CommunityReputaion.objects.get(user=instance.user, community=instance.community).published_by_me_count >= self.badge_score.articles_published_by_me_level_3

class PALevel4(MetaBadge):
    id = 'pa-level-4'
    model = CommunityReputaion
    one_time_only = True

    title = 'PA'
    description = 'PA'
    level = '4'
    
    badge_score = BadgeScore.objects.get_or_create()[0]

    progress_start = 0
    progress_finish = badge_score.articles_published_by_me_level_4

    def get_progress(self, user, community):
        return CommunityReputaion.objects.get(user=user, community=community).published_by_me_count

    def get_user(self, instance):
        return instance.user

    def get_community(self, instance):
        return instance.community

    def check_articles_published_by_me_count(self, instance):
        return CommunityReputaion.objects.get(user=instance.user, community=instance.community).published_by_me_count >= self.badge_score.articles_published_by_me_level_4

class PALevel5(MetaBadge):
    id = 'pa-level-5'
    model = CommunityReputaion
    one_time_only = True

    title = 'PA'
    description = 'PA'
    level = '5'
    
    badge_score = BadgeScore.objects.get_or_create()[0]

    progress_start = 0
    progress_finish = badge_score.articles_published_by_me_level_5

    def get_progress(self, user, community):
        return CommunityReputaion.objects.get(user=user, community=community).published_by_me_count

    def get_user(self, instance):
        return instance.user

    def get_community(self, instance):
        return instance.community

    def check_articles_published_by_me_count(self, instance):
        return CommunityReputaion.objects.get(user=instance.user, community=instance.community).published_by_me_count >= self.badge_score.articles_published_by_me_level_5
