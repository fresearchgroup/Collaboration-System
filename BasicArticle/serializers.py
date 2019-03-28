from rest_framework import serializers
from .models import Articles

class ArticleSerializer(serializers.ModelSerializer):
	created_by = serializers.ReadOnlyField(source='created_by.username')
	class Meta:
		model = Articles
		fields = ('pk','title', 'body', 'image','created_by')

	def create(self, validated_data):
		return Articles.objects.create(created_by=self.context['request'].user, **validated_data)
