from rest_framework import generics
from Course.models import Course, Links
from .serializers import CourseSerializer, TopicsLinksSerializer
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

