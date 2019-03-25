from rest_framework import serializers
from Media.models import Media


class MediaCreateSerializer(serializers.ModelSerializer):
	class Meta:
		model = Media
		fields = ('mediatype', 'title', 'mediafile', 'medialink', 'created_by')


		read_only_fields = ('created_by',)