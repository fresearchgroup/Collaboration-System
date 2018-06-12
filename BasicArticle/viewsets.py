from .models import Articles
<<<<<<< HEAD
from voting.models import Voting
from django.views.generic.edit import UpdateView
from rest_framework import viewsets
from .serializers import ArticleSerializer,VotingSerializer
=======
from django.views.generic.edit import UpdateView
from rest_framework import viewsets
from .serializers import ArticleSerializer
>>>>>>> 4e9d5cfe150a17592b3168794230d17099aa2ed2


# Create your views here.

#this is a rest api serializer class for accessing article models
class ArticleViewSet(viewsets.ModelViewSet):
	queryset = Articles.objects.all().order_by('-title')
	serializer_class = ArticleSerializer
<<<<<<< HEAD
class VotingViewSet(viewsets.ModelViewSet):
	queryset = Voting.objects.all()
	serializer_class1 = VotingSerializer
=======
>>>>>>> 4e9d5cfe150a17592b3168794230d17099aa2ed2
