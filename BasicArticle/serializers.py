from rest_framework import serializers
from .models import Articles
from voting.models import Voting

class ArticleSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
		model = Articles
		fields = ('id','title', 'body')

class VotingSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
		model = Voting
		fields = ('upvote', 'downvote')
