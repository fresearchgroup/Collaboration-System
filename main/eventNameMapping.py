import re

from . import urls
from . import handlers

def get_eventName_from_request(request):
    
    """
        This is a function which is used to map the specific url
        type to the event name using the EVENTS_DICT importing
        from settings file
    """
    url = request.META['PATH_INFO']
    method = request.method
    EVENTS_DICT = getattr(urls, 'EVENT_NAME_DICT', {})

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
