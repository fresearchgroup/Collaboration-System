from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from .serializers import CommunityReputaionSerializer
from Reputation.models import CommunityReputaion

@api_view(['GET'])
def get_reputation(request):
    if request.user.is_authenicated:
        if request.method == 'GET':
            serializer = CommunityReputaionSerializer(data=request.data)
            if serializer.is_valid():
                cid = serializer.data['cid']
                if CommunityReputaion.objects.filter(community=cid, user = request.user).exists():
                    rep = CommunityReputaion.objects.get(community=cid, user = request.user)
                    rep = CommunityReputaionSerializer(rep, many=False)
                    return Response(rep.data)
                else:
                    pass
            else:
                pass



