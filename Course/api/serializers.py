from rest_framework import serializers
from Course.models import Course

class CourseSerializer(serializers.ModelSerializer):
	class Meta:
		model = Course
		fields = [
			'pk',
			'name',
			'desc'
		]