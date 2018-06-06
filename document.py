from django_elasticsearch_dsl import DocType, Index, fields
from elasticsearch_dsl import analyzer
from essearch.models  import Events

events = Index('trial2')

@events.doc_type
class EventDoc (DocType):

	event-source = fields.StringField(
        fields={
            'raw': fields.StringField(analyzer='keyword'),
        }
    )

    event.user-id = fields.StringField(
        fields={
            'raw': fields.StringField(analyzer='keyword'),
        }
    )

    event_name = fields.StringField(
        fields={
            'raw': fields.StringField(analyzer='keyword'),
        }
    )

    hosts = fields.StringField(
        fields={
            'raw': fields.StringField(analyzer='keyword'),
        }
    )

    ip-address = fields.StringField(
        fields={
            'raw': fields.StringField(analyzer='keyword'),
        }
    )

    path-info = fields.StringField(
        fields={
            'raw': fields.StringField(analyzer='keyword'),
        }
    )

    referer = fields.StringField(
        fields={
            'raw': fields.StringField(analyzer='keyword'),
        }
    )

    session-id = fields.StringField(
        fields={
            'raw': fields.StringField(analyzer='keyword'),
        }
    )

    event.community-id = fields.IntegerField(attr='id')

	class Meta:
		model = Events
