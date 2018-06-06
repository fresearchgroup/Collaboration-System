import json

from django_elasticsearch_dsl_drf.serializers import DocumentSerializer

class EventSerializer(DocumentSerializer):
	location = serializers.SerializerMethodField()
	class Meta(object):
		fields = (
			'event-source',
			'event.community-id',
			'event.user-id',
			'event_name',
			'host',
			'ip-address',
			'path-info',
			'referer',
			'session-id',
			)
