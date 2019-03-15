from rest_framework import serializers
from .models import Community, CommunityArticles, CommunityMembership
from django.contrib.auth.models import Group as Roles

class CommunitySerializer(serializers.ModelSerializer):
	created_by = serializers.ReadOnlyField(source='created_by.username')
	class Meta:
		model = Community
		fields = ('id', 'name', 'desc','category', 'created_at', 'created_by', 'pk')



class CommunityArticlesSerializer(serializers.ModelSerializer):
	articleid = serializers.ReadOnlyField(source='article.id')
	title = serializers.ReadOnlyField(source='article.title')
	body = serializers.ReadOnlyField(source='article.body')
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
			'created_by',
			'created_at',
			'published_on',
			'state',
			'communityname',
			'communityid'

		]

class CommunityRoleSerializer(serializers.ModelSerializer):
	class Meta:
		model = Roles
		fields = ['name']

class CommunityMembershipSerializer(serializers.ModelSerializer):
	community = CommunitySerializer(read_only=True)
	role = CommunityRoleSerializer(read_only=True)

	class Meta:
		model = CommunityMembership
		fields = [
			'user',
			'community',
			'role'
		]