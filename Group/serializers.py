from rest_framework import serializers
from .models import Group, GroupArticles

class GroupSerializer(serializers.ModelSerializer):
	class Meta:
		model = Group
		fields = ('id', 'name', 'desc', 'created_at', 'created_by')



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