from .. import utils

LOG_CLASS = "Handlers"

def article_event_type(obj):

    """
        Different events occurs with the POST request on 
        the same url to differentiate between different
        event type this function is utilized
    """
    print(obj)
    if obj['state'][0] == 'save':
        return 'article_edited'
    elif obj['state'][0] == 'visible':
        return 'article_visible'
    elif obj['state'][0] == 'publishable':
        return 'article_publishable'
    elif obj['state'][0] == 'publish':
        return 'article_published'
    elif obj['state'][0] == 'private':
        return 'article_private'
    elif obj['state'][0] == 'public':
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
def group_create_handler(obj):
    utils.ilog(LOG_CLASS, "group_create_handler called", mode="DEBUG")
    st = obj['status'][0]
    if st == '1':
        return 'group_create'
    else:
        return None
