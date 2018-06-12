from .. import utils

def article_event_type(object):

    """
        Different events occurs with the POST request on 
        the same url to differentiate between different
        event type this function is utilized
    """
    print(object)
    if object['state'][0] == 'save':
        return 'article_edited'
    elif object['state'][0] == 'visible':
        return 'article_visible'
    elif object['state'][0] == 'publishable':
        return 'article_publishable'
    elif object['state'][0] == 'published':
        return 'article_published'
    elif object['state'][0] == 'private':
        return 'article_private'
    elif object['state'][0] == 'public':
        return 'article_public'
    else:
        return None

def article_create_handler(obj):
    utils.ilog(LOG_CLASS, "article handler called", mode="DEBUG")
    st = obj['status'][0]
    if st == '1':
        return "article_create"
    else:
        return None

