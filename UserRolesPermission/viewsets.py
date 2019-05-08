from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from UserRolesPermission.serializers import UserSerializer
from django.contrib.auth.models import User
from rest_framework.authtoken.models import Token

from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework_simplejwt.views import TokenObtainPairView

from rest_framework_simplejwt.tokens import RefreshToken

class MyTokenObtainPairSerializer(TokenObtainPairSerializer):
    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)

        token['username'] = user.username

        return token

class MyTokenObtainPairView(TokenObtainPairView):
    serializer_class = MyTokenObtainPairSerializer
    

class RegistrationViewsets(APIView):
    """ 
    Creates the user. 
    """
    def get_tokens_for_user(self, user):
        refresh = MyTokenObtainPairSerializer().get_token(user)

        return {
            'refresh': str(refresh),
            'access': str(refresh.access_token),
        }

    def post(self, request, format='json'):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            user = serializer.save()
            if user:
                tokens = self.get_tokens_for_user(user)
                return Response(tokens, status=status.HTTP_201_CREATED)

        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

