from rest_framework import serializers
from Community.models import Community
from django.contrib.auth.models import Group as Roles
from django.urls import reverse

class SearchCommunitySerializer(serializers.ModelSerializer):
	url = serializers.SerializerMethodField()
	created_by = serializers.ReadOnlyField(source='created_by.username')
	title = serializers.ReadOnlyField(source='name')
	class Meta:
		model = Community
		fields = ( 'url', 'title', 'desc', 'image', 'created_at', 'created_by')

	def get_url(self, obj):
		try:
			#return reverse('community_view', kwargs={'pk': obj.id})
			return self.context['request'].build_absolute_uri(reverse('community_view', kwargs={'pk': obj.id}))
		except AttributeError:
			return None