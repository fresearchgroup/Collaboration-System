from . import logprocess
from . import eventNameMapping

COMMON_FIELDS = {
            "user-agent": logprocess.process_user_agent,
            "ip-addres": logprocess.process_host_ip,
            "server-host": logprocess.process_server_host,
            "referer": logprocess.process_referer,
            "accept-language": logprocess.process_accept_language,
            "session-id": logprocess.process_session_id,
            "path-info": logprocess.process_path_info,
            "time-stamp": logprocess.process_time_stamp,
            "event-source": logprocess.proces_attach_event_source
        }

CONTEXT_SPECIFIC_FIELDS = {

        #article specific events
        "event.article.create":{
            "article-id": logprocess.process_article_info,
            "user-id": logprocess.process_user_info,
            "community-id": logprocess.process_cid,
            "group-id": logprocess.process_gid
            },
        "event.article.view": {
            "article-id": logprocess.process_article_info,
            "user-id": logprocess.process_user_info
            },
        "event.article.edit": {
            "article-id": logprocess.process_article_info,
            "user-id": logprocess.process_user_info
            },
        "event.article.statusChange": {
            "article-id": logprocess.process_article_info,
            "user-id": logprocess.process_user_info,
            "status": logprocess.process_article_state
            },
        "event.article.published": {
            "article-id": logprocess.process_article_info,
            "publisher-id": logprocess.process_user_info
            },
        "event.article.deleted": {
            "article-id": logprocess.process_article_info,
            "user-id": logprocess.process_user_info
            },
        "event.article.reported": {
            "article-id": logprocess.process_article_info,
            "user-id": logprocess.process_user_info
            },

        #community specific events
        "event.community.view": {
            "community-id": logprocess.process_community_info,
            "user-id": logprocess.process_user_info
            },
        "event.community.subscribe":{
            "community-id": logprocess.process_community_info,
            "user-id": logprocess.process_user_info
            },
        }

# This dictionary is used to map the url to the event names
EVENT_NAME_DICT={
    
    # handles community view event
    r'^community-view/(?P<pk>\d+)/$':{
        'GET':{
               'event_name' : 'event.community.view'
        }
    },
    
    #handles article view event
    r'^article-view/(?P<pk>\d*)/$':{
        'GET':{
              'event_name' : 'event.article.view'
        }
    },
    
    #handles article edited, visible, publishable, published events 
    r'^article-edit/(?P<pk>\d*)/$':{
        'POST':{
              'function'   : eventNameMapping.article_event_type,
              'article_edited' : 'event.article.edited',
              'article_visible' : 'event.article.statusChanged',
              'article_publishable' :'event.article.statusChanged',
              'article_published' : 'event.article.published'
        }
    },
}