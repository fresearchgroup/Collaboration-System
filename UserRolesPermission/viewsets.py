from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from UserRolesPermission.serializers import UserSerializer
from django.contrib.auth.models import User




class UserCreate(APIView):
    """ 
    Creates the user. 
    """

    def post(self, request, format='json'):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            if user:
                return Response(serializer.data, status=status.HTTP_201_CREATED)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)