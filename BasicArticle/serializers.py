from rest_framework import serializers
from .models import Articles
from voting.models import VotingFlag

class ArticleSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
		model = Articles
		fields = ('id','title', 'body')

class VotingFlagSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
		model = VotingFlag
		fields = ('upvote', 'downvote')
