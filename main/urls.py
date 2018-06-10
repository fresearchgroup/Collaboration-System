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

    #community create
    r'^create_community/$':{
        'POST':{
            'event_name' : 'event.community.create'
        }
    },

    #group create event
    r'^community-group-create/$':{
        'POST':{
            'event_name' : 'event.group.create'
        }
    },

    #group manage events
    r'^manage_group/(?P<pk>\d+)/$':{
        'POST':{
            'event_name' : 'event.group.manage'
        }
    },

    #community content view event
    r'^community_content/(?P<pk>\d+)/$':{
        'GET':{
            'event_name' : 'event.content.view'
        }
    },

    #course create event
    r'^community-course-create/$':{
        'POST':{
            'event_name' : 'event.course.create'
        }
    },

    #course view event
    r'^course-view/(?P<pk>\d*)/$':{
        'GET':{
            'event_name' : 'event.course.view'
        }
    },

    #course edit event
    r'^course-edit/(?P<pk>\d*)/$':{
        'POST':{
            'event_name' : 'event.course.edit'
        }
    },

    #course manage-resource event
    r'^manage-resource/(?P<pk>\d+)/$':{
        'POST':{
            'event_name' : 'event.course.manage'
        }
    },

    #update course-info event
    r'^update-course-info/(?P<pk>\d+)/$':{
        'POST':{
            'event_name' : 'event.course.update'
        }
    },

    #comment post event
    r'^comments/':{
        'POST':{
            'event_name' : 'event.comment.post'
        }
    },

    #article create events
    r'^community-article-create/$': {
        'POST':{
            'event_name': 'event.article.create'
        }
    },
    r'^group-article-create/$': {
        'POST':{
            'event_name': 'event.article.create'
        }
    },

}
