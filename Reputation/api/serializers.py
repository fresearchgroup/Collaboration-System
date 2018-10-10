from rest_framework import serializers
from Reputation.models import CommunityReputaion
from Reputation.models import ArticleScoreLog, ArticleVotedByLogs

class CommunityReputaionSerializer(serializers.ModelSerializer):
    class Meta:
        model = CommunityReputaion
        fields = [
            'community',
            'user',
            'score'
        ]
        
class ArticleScoreLogSerializaer(serializers.ModelSerializer):
    class Meta:
        model = ArticleScoreLog
        fields = [
            'article',
            'upvote',
            'downvote',
            'reported',
            'publish'
        ]
class ArticleVotedByLogsSerializer(serializers.ModelSerializer):
    class Meta:
        model = ArticleVotedByLogs
        fields = [
            'article',
            'user',
            'upvoted',
            'downvoted',
            'reported'
        ]