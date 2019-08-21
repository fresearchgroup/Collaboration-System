from .schema import CommunityIndex

def create_community_search_index(sender, instance, created, **kwargs):
	if created:
		cindex = CommunityIndex(
						name=instance.name, 
						desc=instance.desc, image=instance.image.url, 
						image_thumbnail=instance.image_thumbnail.url, 
						tag_line=instance.tag_line, 
						created_at=instance.created_at,
						created_by=instance.created_by.username,
						parent=instance.parent.name
						)
		cindex.save()