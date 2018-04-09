from rest_framework import generics
from Course.models import Course
from .serializers import CourseSerializer


class CourseApiView(generics.RetrieveUpdateDestroyAPIView):
	lookup_field = 'pk'
	serializer_class = CourseSerializer

	def get_queryset(self):
		return Course.objects.all()