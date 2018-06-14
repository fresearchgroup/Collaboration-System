from .models import Articles
from voting.models import VotingFlag
from django.views.generic.edit import UpdateView
from rest_framework import viewsets
from .serializers import ArticleSerializer,VotingFlagSerializer


# Create your views here.

#this is a rest api serializer class for accessing article models
class ArticleViewSet(viewsets.ModelViewSet):
	queryset = Articles.objects.all().order_by('-title')
	serializer_class = ArticleSerializer
class VotingFlagViewSet(viewsets.ModelViewSet):
	queryset = VotingFlag.objects.all()
	serializer_class1 = VotingFlagSerializer
