from django.core.management.base import BaseCommand, CommandError
from Community.models import Community
from BasicArticle.models import Articles
from Media.models import Media
from search.schema import CommunityIndex, ArticleIndex, MediaIndex
from workflow.models import States
from django.conf import settings

class Command(BaseCommand):
	help = 'Index all resources in collaboration system'

	def handle(self, *args, **options):
		if settings.ELASTICSEARCH_RUNNING:
			community = Community.objects.all()
			articles = Articles.objects.filter(state=States.objects.get(final=True))
			media = Media.objects.filter(state=States.objects.get(final=True))

			#initialize the indexes 
			CommunityIndex.init()
			ArticleIndex.init()
			MediaIndex.init()

			for instance in community:
				cindex = CommunityIndex(
							community_id=instance.pk,
							name=instance.name, 
							desc=instance.desc, 
							image=instance.image.url if instance.image else '', 
							image_thumbnail=instance.image_thumbnail.url if instance.image else '', 
							tag_line=instance.tag_line, 
							created_at=instance.created_at,
							created_by=instance.created_by.username,
							parent=instance.parent.name if instance.parent else ''
						)
				cindex.save()

			for instance in articles:
				aindex = ArticleIndex(
							article_id = instance.pk,
							title = instance.title,
							body = instance.body,
							image = instance.image.url if instance.image else '',
							created_at = instance.created_at,
							created_by = instance.created_by.username,
							published_on = instance.published_on,
							views=instance.views
						) 
				aindex.save()

			for instance in media:
				mindex = MediaIndex(
							media_id = instance.pk,
							title = instance.title,
							mediatype = instance.mediatype,
							mediafile = instance.mediafile.url if instance.mediafile else '',
							medialink = instance.medialink,
							created_at = instance.created_at,
							created_by = instance.created_by.username,
							published_on = instance.published_on,
							published_by = instance.published_by.username if instance.published_by else '',
							views=instance.views
						)
				mindex.save()

			self.stdout.write(self.style.SUCCESS('Successfully created index all resources in elastic search'))
		else:
			self.stdout.write(self.style.WARNING('Elasticsearch serivces are not running'))
