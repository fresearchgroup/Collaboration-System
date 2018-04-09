from rest_framework import generics
from Course.models import Course
from .serializers import CourseSerializer, CommunityCourseSerializer

class CourseCreateApiView(generics.CreateAPIView):
	lookup_field = 'pk'
	serializer_class = CourseSerializer

	def get_queryset(self):
		return Course.objects.all()

	def perform_create(self, serializer):
		serializer.save(created_by=self.request.user)


class CourseRUDApiView(generics.RetrieveUpdateDestroyAPIView):
	lookup_field = 'pk'
	serializer_class = CourseSerializer

	def get_queryset(self):
		return Course.objects.all()