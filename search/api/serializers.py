from rest_framework import serializers
from Community.models import Community, CommunityArticles
from BasicArticle.models import Articles
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
			return self.context['request'].build_absolute_uri(reverse('community_view', kwargs={'pk': obj.id}))
		except AttributeError:
			return None


class SearchArticleSerializer(serializers.ModelSerializer):
	url = serializers.SerializerMethodField()
	created_by = serializers.ReadOnlyField(source='created_by.username')
	desc = serializers.ReadOnlyField(source='body')
	publisher = serializers.ReadOnlyField(source='published_by.username')
	community = serializers.SerializerMethodField()
	class Meta:
		model = Articles
		fields = ( 'url', 'title', 'desc', 'image', 'created_at', 'created_by', 'published_on', 'publisher', 'community')

	def get_url(self, obj):
		try:
			return self.context['request'].build_absolute_uri(reverse('article_view', kwargs={'pk': obj.id}))
		except AttributeError:
			return None

	def get_community(self, obj):
		try:
			return CommunityArticles.objects.get(article=obj.pk).community.name
		except AttributeError:
			return None