from rest_framework import serializers
from .models import Articles

class ArticleSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
		model = Articles
		fields = ('pk','title', 'body', 'image','created_by', 'tags')

		read_only_fields = ('created_by',)
