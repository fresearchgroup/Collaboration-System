from rest_framework import serializers
from .models import Articles
from Community.models import Community, CommunityArticles

class ArticleSerializer(serializers.ModelSerializer):
	created_by = serializers.ReadOnlyField(source='created_by.username')
	class Meta:
		model = Articles
		fields = ('pk','title', 'body', 'image','created_by')

	def create(self, validated_data):
		article= Articles.objects.create(created_by=self.context['request'].user, **validated_data)
		community = Community.objects.get(pk=self.context['view'].kwargs['pk'])
		CommunityArticles.objects.create(article=article, user=article.created_by, community=community)
		return article