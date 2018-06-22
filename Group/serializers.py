from rest_framework import serializers
from .models import  GroupArticles
from Community.models import CommunityGroups

class GroupSerializer(serializers.ModelSerializer):
	groupid = serializers.ReadOnlyField(source='group.id')
	name = serializers.ReadOnlyField(source='group.name')
	desc = serializers.ReadOnlyField(source='group.desc')
	created_at = serializers.ReadOnlyField(source='group.created_at')
	created_by = serializers.ReadOnlyField(source='group.created_by')
	community_id = serializers.ReadOnlyField(source='community.id')
	community_name = serializers.ReadOnlyField(source='community.name')
	class Meta:
		model = CommunityGroups
		fields = ('groupid', 'name', 'desc', 'created_at', 'created_by', 'community_id','community_name')



class GroupArticlesSerializer(serializers.ModelSerializer):
	articleid = serializers.ReadOnlyField(source='article.id')
	title = serializers.ReadOnlyField(source='article.title')
	body = serializers.ReadOnlyField(source='article.body')
	created_by = serializers.ReadOnlyField(source='article.created_by.username')
	created_at = serializers.ReadOnlyField(source='article.created_at')
	published_on = serializers.ReadOnlyField(source='article.published_on')
	state = serializers.ReadOnlyField(source='article.state.name')
	groupname = serializers.ReadOnlyField(source='group.name')
	groupid = serializers.ReadOnlyField(source='group.id')

	class Meta:
		model = GroupArticles
		fields = [

			'articleid',
			'title',
			'body',
			'created_by',
			'created_at',
			'published_on',
			'state',
			'groupname',
			'groupid'

		]