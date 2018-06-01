import re

from . import settings

"""
Different events occurs with the POST request on 
the same url to differentiate between different
event type this function is utilized
"""

def article_event_type(object):
    print(object)
    if    object['state'][0] == 'save':
        return 'article_edited'
    elif  object['state'][0] == 'visible':
        return 'article_visible'
    elif  object['state'][0] == 'publishable':
        return 'article_publishable'
    elif  object['state'][0] == 'published':
        return 'article_published'
    else:
        return None

"""
This is a function which is used to map the specific url
type to the event name using the EVENTS_DICT importing
from settings file
"""
def get_eventName_from_request(request):
    
    url = request.META['PATH_INFO']
    method = request.method
    EVENTS_DICT = getattr(settings, 'EVENT_NAME_DICT', {})

    if url[0] is '/':
        url = url[1:]
      
    for key in EVENTS_DICT:
        if re.match(key,url):
            if method == 'GET':
                if 'GET' in EVENTS_DICT[key]:
                     return EVENTS_DICT[key]['GET']['event_name']
                else:
                     return None
            elif method == 'POST':
                if 'function' in EVENTS_DICT[key]['POST']:
                        event_type = EVENTS_DICT[key]['POST']['function'](dict(request.POST))
                        if event_type is None:
                            return None
                        else:
                            return EVENTS_DICT[key]['POST'][event_type]
                else:
                        return EVENTS_DICT[key]['POST']['event_name']
    return None