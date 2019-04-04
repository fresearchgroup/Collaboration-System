from rest_framework import serializers
from Media.models import Media
from Community.models import Community, CommunityMedia

class MediaCreateSerializer(serializers.ModelSerializer):
	created_by = serializers.ReadOnlyField(source='created_by.username')
	
	class Meta:
		model = Media
		fields = ('mediatype', 'title', 'mediafile', 'medialink', 'created_by')

	def create(self, validated_data):
		media = Media.objects.create(created_by=self.context['request'].user, **validated_data)
		community = Community.objects.get(pk=self.context['view'].kwargs['pk'])
		CommunityMedia.objects.create(media=media, user=media.created_by, community=community )
		return media