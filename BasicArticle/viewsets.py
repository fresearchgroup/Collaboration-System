from .models import Articles
from voting.models import Voting
from django.views.generic.edit import UpdateView
from rest_framework import viewsets
from .serializers import ArticleSerializer,VotingSerializer


# Create your views here.

#this is a rest api serializer class for accessing article models
class ArticleViewSet(viewsets.ModelViewSet):
	queryset = Articles.objects.all().order_by('-title')
	serializer_class = ArticleSerializer
class VotingViewSet(viewsets.ModelViewSet):
	queryset = Voting.objects.all()
	serializer_class1 = VotingSerializer