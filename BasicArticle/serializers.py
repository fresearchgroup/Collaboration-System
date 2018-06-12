from rest_framework import serializers
from .models import Articles
<<<<<<< HEAD
from voting.models import Voting
=======
>>>>>>> 4e9d5cfe150a17592b3168794230d17099aa2ed2

class ArticleSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
		model = Articles
		fields = ('id','title', 'body')
<<<<<<< HEAD

class VotingSerializer(serializers.HyperlinkedModelSerializer):
	class Meta:
		model = Voting
		fields = ('upvote', 'downvote')
=======
>>>>>>> 4e9d5cfe150a17592b3168794230d17099aa2ed2
