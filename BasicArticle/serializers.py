from rest_framework import serializers
from .models import Articles

class ArticleSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
		model = Articles
		fields = ('id','title', 'body')
