from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import generics
from .serializers import CommunityReputaionSerializer
from Reputation.models import CommunityReputaion
from rest_framework.permissions import IsAuthenticated
from Community.models import Community, CommunityMembership


class FetchCommunityReputation(generics.RetrieveUpdateDestroyAPIView):
    lookup_field = 'pk'
    serializer_class = CommunityReputaionSerializer
    permission_classes = (IsAuthenticated,)

    def get_object(self):
        cid = self.kwargs['pk']
        community = Community.objects.get(id=cid)
        if CommunityMembership.objects.filter(community=community, user = self.request.user).exists():
            if CommunityReputaion.objects.filter(community=community, user = self.request.user).exists():
                return CommunityReputaion.objects.get(community=community, user = self.request.user)
            else:
                return CommunityReputaion.objects.create(community=community, user = self.request.user)