from .schema import CommunityIndex

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