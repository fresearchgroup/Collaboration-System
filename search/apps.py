from django.apps import AppConfig
from django.db.models.signals import post_save
from django.conf import settings

class SearchConfig(AppConfig):
	name = 'search'

	def ready(self):
		from Community.models import Community
		from BasicArticle.models import Articles
		from .signals import create_community_search_index, create_article_search_index
		from .schema import CommunityIndex, ArticleIndex

		if settings.ELASTICSEARCH_RUNNING:
			CommunityIndex.init()
			ArticleIndex.init()
			post_save.connect(create_community_search_index, sender=Community, dispatch_uid='create_community_search_index')
			post_save.connect(create_article_search_index, sender=Articles, dispatch_uid='create_article_search_index')
