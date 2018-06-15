'''
    Unit testing of eventNameMapping Module
'''

from django.test import TestCase, RequestFactory
from ..main import eventNameMapping

class SimpleTest(TestCase):
   
    def setUp(self):
        self.factory = RequestFactory()
        self.data_get = {
        
           'test_case_1' : {
                 'input' : '/community-view/1/',
                 'output' : 'event.community.view'
           },

           'test_case_2' : {
                  'input' : '/article-view/2/',
                  'output' : 'event.article.view'
           },

           'test_case_3' : {
                  'input' : '/article-view/2/',
                  'output' : 'event.article.view'
           },

           'test_case_4' : {
                  'input' : '/logout/',
                  'output' : 'event.user.logout'
           },

           'test_case_5' : {
                  'input' : '/userprofile/user/',
                  'output' : 'event.profile.view'
           },
           
           'test_case_6' : {
                  'input' : '/group-view/1/',
                  'output' : 'event.group.view'
           },

           'test_case_7' : {
                  'input' : '/community_content/1/',
                  'output' : 'event.content.view'
           },

           'test_case_8' : {
                  'input' : '/course-view/1/',
                  'output' : 'event.course.view'
           },

           'test_case_9' : {
                  'input' : '/userprofile/user/',
                  'output' : 'event.profile.view'
           },
           
           'test_case_10' : {
                   'input' : '/random/test/',
                   'output' : None
           }
        }
        
        self.data_post = {
           'test_case_1' : {
                   'input' : '/login/',
                   'post'  : {},
                   'output' : 'event.user.login'
           },

           'test_case_2' : {
                   'input' : '/community-subscribe/',
                   'post'  : {},
                   'output' : 'event.community.subscribe'
           },

           'test_case_3' : {
                   'input' : '/community-unsubscribe/',
                   'post'  : {},
                   'output' : 'event.community.unsubscribe'
           },

           'test_case_4' : {
                   'input' : '/group-unsubscribe/',
                   'post'  : {},
                   'output' : 'event.group.unsubscribe'
           },

           'test_case_5' : {
                   'input' : '/create_community/',
                   'post'  : {},
                   'output' : 'event.community.create'
           },

           'test_case_6' : {
                   'input' : '/community-group-create/',
                   'post'  : {},
                   'output' : 'event.group.create'
           },

           'test_case_7' : {
                   'input' : '/manage_group/1/',
                   'post'  : {},
                   'output' : 'event.group.manage'
           },

           'test_case_8' : {
                   'input' : '/community-course-create/',
                   'post'  : {},
                   'output' : 'event.course.create'
           },

           'test_case_9' : {
                   'input' : '/course-edit/1/',
                   'post'  : {},
                   'output' : 'event.course.edit'
           },
            
            'test_case_10' : {
                   'input' : '/course-edit/1/',
                   'post'  : {},
                   'output' : 'event.course.edit'
           },

           'test_case_11' : {
                   'input' : '/manage-resource/1/',
                   'post'  : {},
                   'output' : 'event.course.manage'
           },

           'test_case_12' : {
                   'input' : '/update-course-info/1/',
                   'post'  : {},
                   'output' : 'event.course.update'
           },

           'test_case_13' : {
                   'input' : '/comments/',
                   'post'  : {},
                   'output' : 'event.comment.post'
           },

           'test_case_13' : {
                   'input' : '/article-edit/1/',
                   'post' : {
                       'state' : ['save']
                   },
                   'output' : 'event.article.edit'
           },

           'test_case_14' : {
                   'input' : '/article-edit/1/',
                   'post' : {
                       'state' : ['visible']
                   },
                   'output' : 'event.article.statusChanged'
           },

           'test_case_15' : {
                   'input' : '/article-edit/1/',
                   'post' : {
                       'state' : ['publishable']
                   },
                   'output' : 'event.article.statusChanged'
           },

           'test_case_16' : {
                   'input' : '/article-edit/1/',
                   'post' : {
                       'state' : ['private']
                   },
                   'output' : 'event.article.statusChanged'
           },

           'test_case_17' : {
                   'input' : '/article-edit/1/',
                   'post' : {
                       'state' : ['public']
                   },
                   'output' : 'event.article.statusChanged'
           },

           'test_case_18' : {
                   'input' : '/article-edit/1/',
                   'post' : {
                       'state' : ['published']
                   },
                   'output' : 'event.article.published'
           },

           'test_case_19' : {
                   'input' : '/community-article-create/',
                   'post' : {
                       'status' : ['1']
                   },
                   'output' : 'event.article.create'
           },

           'test_case_20' : {
                   'input' : '/group-article-create/',
                   'post' : {
                       'status' : ['1']
                   },
                   'output' : 'event.article.create'
           },

           'test_case_21' : {
                   'input' : '/random/testing/',
                   'post' : {},
                   'output' : None
           },
        }

    def test_get_requests(self):
        for key in self.data_get:
           request = self.factory.get(self.data_get[key]['input'])
           response = eventNameMapping.get_eventName_from_request(request)
           self.assertEqual(response, self.data_get[key]['output'])

    def test_post_requests(self):
        for  key in self.data_post:
             request = self.factory.post(self.data_post[key]['input'],self.data_post[key]['post'])
             response = eventNameMapping.get_eventName_from_request(request)
             self.assertEqual(response,self.data_post[key]['output'])
       



