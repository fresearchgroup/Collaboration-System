OUTTER_KEYS = [
        'server-host',
        'ip-address',
        'session-id',
        'path-info',
        'accept-language',
        'user-agent',
        'referer',
        'event-source',
        'time-stamp',
        'event_name',
        'host',
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
        ]

ES_INDEX = 'logs'

SERVER_CONF = [ "elasticsearch" ]
