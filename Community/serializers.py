from rest_framework import serializers
from .models import Community, CommunityArticles

class CommunitySerializer(serializers.ModelSerializer):
	class Meta:
		model = Community
		fields = ('name', 'desc','category', 'created_at', 'created_by')



class CommunityArticlesSerializer(serializers.ModelSerializer):
	title = serializers.ReadOnlyField(source='article.title')
	body = serializers.ReadOnlyField(source='article.body')
	created_by = serializers.ReadOnlyField(source='article.created_by.username')
	created_at = serializers.ReadOnlyField(source='article.created_at')
	published_on = serializers.ReadOnlyField(source='article.published_on')
	state = serializers.ReadOnlyField(source='article.state.name')
	cname = serializers.ReadOnlyField(source='community.name')

	class Meta:
		model = CommunityArticles
		fields = [

			'article',
			'title',
			'body',
			'created_by',
			'created_at',
			'published_on',
			'state',
			'cname'

		]