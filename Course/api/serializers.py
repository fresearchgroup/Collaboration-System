from rest_framework import serializers
from Course.models import Course, Links, TopicArticle, Topics
from Community.models import CommunityCourses, Community

class CourseSerializer(serializers.ModelSerializer):
	community = serializers.IntegerField( write_only=True)
	class Meta:
		model = Course
		fields = [
			'title',
			'body',
			'created_by',
			'community'
		]
		read_only_fields = ('created_by',)


	def create(self, validated_data):

		obj = Course.objects.create(title=validated_data.get('title'),
			body =validated_data.get('body'),
			created_by = self.context['request'].user
		)
		community = Community.objects.get(pk=validated_data.get('community'))
		CommunityCourses.objects.create(course=obj, user=self.context['request'].user, community=community)
		return obj


class TopicsLinksSerializer(serializers.ModelSerializer):
	class Meta:
		model = Links
		fields = [
			'id',
			'link',
			'desc',
			'types'
		]

class TopicArticleSerializer(serializers.ModelSerializer):
       title = serializers.ReadOnlyField(source='article.title')
       body = serializers.ReadOnlyField(source='article.body')
       created_by = serializers.ReadOnlyField(source='article.created_by.username')
       created_at = serializers.ReadOnlyField(source='article.created_at')

       class Meta:
               model = TopicArticle
               fields = [
			   			'id',
						'article',
						'title',
						'body',
						'topics',
						'created_by',
						'created_at'
               ]


class TopicsSerializer(serializers.ModelSerializer):
	class Meta:
		model = Topics
		fields = [
			'id',
			'name',
		]