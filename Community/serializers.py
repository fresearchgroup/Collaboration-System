from rest_framework import serializers
from .models import Community

class CommunitySerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
		model = Community
		fields = ('name', 'desc','category')
