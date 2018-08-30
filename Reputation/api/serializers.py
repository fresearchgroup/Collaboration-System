from rest_framework import serializers
from Reputation.models import CommunityReputaion

class CommunityReputaionSerializer(serializers.ModelSerializer):
    class Meta:
        model = CommunityReputaion
        fields = [
            'community',
            'user',
            'score'
        ]
        