from rest_framework import serializers
from Community.models import Community, CommunityArticles, CommunityMedia, CommunityMembership

class CommunitySerializer(serializers.ModelSerializer):
	created_by = serializers.ReadOnlyField(source='created_by.username')
	class Meta:
		model = Community
		fields = ('id', 'name', 'desc', 'image', 'category', 'created_at', 'created_by')



class CommunityArticlesSerializer(serializers.ModelSerializer):
	articleid = serializers.ReadOnlyField(source='article.id')
	title = serializers.ReadOnlyField(source='article.title')
	body = serializers.ReadOnlyField(source='article.body')
	image = serializers.ImageField(source='article.image')
	created_by = serializers.ReadOnlyField(source='article.created_by.username')
	created_at = serializers.ReadOnlyField(source='article.created_at')
	published_on = serializers.ReadOnlyField(source='article.published_on')
	state = serializers.ReadOnlyField(source='article.state.name')
	communityname = serializers.ReadOnlyField(source='community.name')
	communityid = serializers.ReadOnlyField(source='community.id')

	class Meta:
		model = CommunityArticles
		fields = [

			'articleid',
			'title',
			'body',
			'image',
			'created_by',
			'created_at',
			'published_on',
			'state',
			'communityname',
			'communityid'

		]

class CommunityMediaSerializer(serializers.ModelSerializer):
	mediaid = serializers.ReadOnlyField(source='media.id')
	mediatype = serializers.ReadOnlyField(source='media.mediatype')
	title = serializers.ReadOnlyField(source='media.title')
	mediafile = serializers.FileField(source='media.mediafile')
	medialink = serializers.ReadOnlyField(source='media.medialink')
	created_at = serializers.ReadOnlyField(source='media.created_at')
	created_by = serializers.ReadOnlyField(source='media.created_by.username')
	published_on = serializers.ReadOnlyField(source='media.published_on')
	state = serializers.ReadOnlyField(source='media.state.name')
	views = serializers.ReadOnlyField(source='media.views')
	communityname = serializers.ReadOnlyField(source='community.name')
	communityid = serializers.ReadOnlyField(source='community.id')

	class Meta:
		model = CommunityMedia
		fields = [
			'mediaid',
			'mediatype',
			'title',
			'mediafile',
			'medialink',
			'created_at',
			'created_by',
			'published_on',
			'state',
			'views',
			'communityname',
			'communityid'

		]

class CommunityMembershipSerializer(serializers.ModelSerializer):
	user = serializers.ReadOnlyField(source='user.username')
	community = serializers.ReadOnlyField(source='community.name')
	role = serializers.ReadOnlyField(source='role.name')

	class Meta:
		model = CommunityMembership
		fields = ['user', 'community', 'role']