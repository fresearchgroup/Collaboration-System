from rest_framework import serializers
from Media.models import Media


class MediaCreateSerializer(serializers.ModelSerializer):
	created_by = serializers.ReadOnlyField(source='created_by.username')
	
	class Meta:
		model = Media
		fields = ('mediatype', 'title', 'mediafile', 'medialink', 'created_by')

	def create(self, validated_data):
		return Media.objects.create(created_by=self.context['request'].user, **validated_data)