from rest_framework import serializers
from Reputation.models import CommunityReputaion
from Reputation.models import ArticleScoreLog, ArticleUserScoreLogs

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
            'resource',
            'upvote',
            'downvote',
            'reported',
            'publish'
        ]
class ArticleUserScoreLogsSerializer(serializers.ModelSerializer):
    class Meta:
        model = ArticleUserScoreLogs
        fields = [
            'resource',
            'user',
            'upvoted',
            'downvoted',
            'reported'
        ]