from django.apps import AppConfig
from django.db.models.signals import post_save

class SearchConfig(AppConfig):
	name = 'search'

	def ready(self):
		from Community.models import Community
		from .signals import create_community_search_index
		from .schema import CommunityIndex
		from elasticsearch_dsl.connections import connections
		connections.create_connection(hosts=['localhost:9200'])
		CommunityIndex.init()
		post_save.connect(create_community_search_index, sender=Community, dispatch_uid='create_community_search_index')
