from django.shortcuts import render

from django_elasticsearch_dsl_drf.filter_backends import (
    FilteringFilterBackend,
    OrderingFilterBackend,
    SearchFilterBackend,
)
from django_elasticsearch_dsl_drf.viewsets import DocumentViewSet

from .document import EventDoc
from .serializers import EventSerializer

class EventDocView(DocumentViewSet):
	document = EventDoc
	serializer_class = EventSerializer
	filter_backends = [
        FilteringFilterBackend,
        OrderingFilterBackend,
        DefaultOrderingFilterBackend,
        SearchFilterBackend,
    ]

    search_fields = (
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
    filter_fields = {
    	'event-source': 'event-source.raw'
		'event.community-id',
		'event.user-id',
		'event_name',
		'host',
		'ip-address',
		'path-info',
		'referer',
		'session-id',
    }
