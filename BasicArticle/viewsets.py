from .models import Articles
from django.views.generic.edit import UpdateView
from rest_framework import viewsets
from .serializers import ArticleSerializer
from rest_framework.permissions import IsAuthenticatedOrReadOnly

# Create your views here.

#this is a rest api serializer class for accessing article models
class ArticleViewSet(viewsets.ModelViewSet):
	queryset = Articles.objects.all().order_by('-title')
	serializer_class = ArticleSerializer
	permission_classes = (IsAuthenticatedOrReadOnly,)