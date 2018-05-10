from rest_framework import generics
from Course.models import Course, Links, TopicArticle, Topics
from .serializers import CourseSerializer, TopicsLinksSerializer, TopicArticleSerializer , TopicsSerializer
from Community.models import Community
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticatedOrReadOnly

class CourseCreateApiView(generics.CreateAPIView):
	lookup_field = 'pk'
	serializer_class = CourseSerializer

	def get_queryset(self):
		return Course.objects.all()

class CourseRUDApiView(generics.RetrieveUpdateDestroyAPIView):
	lookup_field = 'pk'
	serializer_class = CourseSerializer

	def get_queryset(self):
		return Course.objects.all()


class TopicsLinksApiView(generics.ListAPIView):
	lookup_field = 'pk'
	serializer_class = TopicsLinksSerializer
	permission_classes = (IsAuthenticatedOrReadOnly,)

	def get_queryset(self):
		topics = self.kwargs['pk']
		return Links.objects.filter(topics=topics)

class TopicArticleApiView(generics.ListAPIView):
       lookup_field = 'pk'
       serializer_class = TopicArticleSerializer
       permission_classes = (IsAuthenticatedOrReadOnly,)

       def get_queryset(self):
               topics = self.kwargs['pk']
               return TopicArticle.objects.filter(topics=topics)

class LinksDetailsApiView(generics.RetrieveUpdateDestroyAPIView):
	lookup_field = 'pk'
	serializer_class = TopicsLinksSerializer
	permission_classes = (IsAuthenticatedOrReadOnly,)

	def get_queryset(self):
		pk = self.kwargs['pk']
		return Links.objects.filter(pk=pk)

class TopicsApiView(generics.ListAPIView):
	lookup_field = 'pk'
	serializer_class = TopicsSerializer
	permission_classes = (IsAuthenticatedOrReadOnly,)

	def get_queryset(self):
		course = self.kwargs['pk']
		return Topics.objects.filter(course=course)
