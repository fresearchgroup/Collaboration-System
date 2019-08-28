from .schema import CommunityIndex, ArticleIndex, MediaIndex
from workflow.models import States

def create_community_search_index(sender, instance, created, **kwargs):
	if created:
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


def create_article_search_index(sender, instance, created, **kwargs):
	if instance.state == States.objects.get(final=True):
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


def create_media_search_index(sender, instance, created, **kwargs):
	if instance.state == States.objects.get(final=True):
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
