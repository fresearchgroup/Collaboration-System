from . import handlers

# This dictionary is used to map the url to the event names
EVENT_NAME_DICT={
    
    # maps community view event
    r'^community-view/(?P<pk>\d+)/$':{
        'GET':{
               'event_name' : 'event.community.view'
        }
    },
    
    #maps article view event
    r'^article-view/(?P<pk>\d*)/$':{
        'GET':{
              'event_name' : 'event.article.view'
        }
    },
    
    #maps article edited, visible, publishable, published events 
    r'^article-edit/(?P<pk>\d*)/$':{
        'POST':{
              'function' : handlers.article_event_type,
              'article_edited' : 'event.article.edited',
              'article_visible' : 'event.article.statusChanged',
              'article_publishable' :'event.article.statusChanged',
              'article_published' : 'event.article.published'
        }
    },

    #maps  login event
    r'^login/$':{
        'POST':{
             'event_name' : 'event.user.login',
        }
    },

    #maps logout event
    r'^logout/$':{
        'GET':{
             'event_name' : 'event.user.logout'
        }
    },

    #maps community subscribe event
    r'^community-subscribe/$':{
       'POST':{
             'event_name' : 'event.community.subscribe'
       }
    },

    #maps community unsubscribe event
    r'^community-unsubscribe/$':{
         'POST':{
              'event_name' : 'event.community.unsubscribe'
         }
    },

    #maps profile view event
    r'^userprofile/(?P<username>[\w.@+-]+)/$':{
        'GET':{
              'event_name' : 'event.profile.view'
        }
    },

    #group view
    r'^group-view/(?P<pk>\d+)/$':{
       'GET':{
             'event_name' :  'event.group.view'
       }
    },

    #group unsubscribe
    r'^group-unsubscribe/$':{
       'POST':{
             'event_name' : 'event.group.unsubscribe'
       }
    },

}
