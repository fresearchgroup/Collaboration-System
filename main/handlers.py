"""
Different events occurs with the POST request on 
the same url to differentiate between different
event type this function is utilized
"""

def article_event_type(object):
    print(object)
    if object['state'][0] == 'save':
        return 'article_edited'
    elif object['state'][0] == 'visible':
        return 'article_visible'
    elif object['state'][0] == 'publishable':
        return 'article_publishable'
    elif object['state'][0] == 'published':
        return 'article_published'
    else:
        return None

