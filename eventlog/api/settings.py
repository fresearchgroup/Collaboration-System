from decouple import config
OUTTER_KEYS = [
        'server-host',
        'ip-address',
        'session-id',
        'path-info',
        'accept-language',
        'user-agent',
        'referer',
        'host',
        'event-source',
        'time-stamp',
        'event_name',
        '@version',
        'headers',
        '@timestamp',
        'user-id'
    ]

INNER_KEYS = [
        'article-id',
        'community-id',
        'group-id',
        'status',
        'publisher-id',
        'username',
        'user-visited',
        'admin-username',
        'community-name',
        'group-name',
        'invitation-username',
        'role',
        'course-id',
        'course-name',
        'reply-to-user-id',
        'object-pk',
        'article-state'
        ]

ES_INDEX = 'logs'

AGGREGATE_FUNCS = [
        'cardinality',
        'value_count',
        'terms'
        ]

SERVER_CONF = [ "elasticsearch" ]

PAGE_SIZE = config('PAGE_SIZE', cast=int)
MAX_PAGE_SIZE = config('MAX_PAGE_SIZE', cast=int)
