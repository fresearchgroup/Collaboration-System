from rest_framework import serializers
from Course.models import Course
from Community.models import CommunityCourses

class CommunityCourseSerializer(serializers.ModelSerializer):
	class Meta:
		model = CommunityCourses
		fields = [
			'course',
			'user',
			'community'
		]
		
class CourseSerializer(serializers.ModelSerializer):
	class Meta:
		model = Course
		fields = [
			'pk',
			'title',
			'body',
			'created_at',
			'created_by'
		]
		read_only_fields = ('created_by',)