'''
    Unit Test cases for Logprocess.py module
'''

from ..main import logprocess
import unittest
from django.test import RequestFactory

class TestLogprocess(unittest.TestCase):

    def setUp(self):
        factory=RequestFactory()
        request1=factory.post('/community-article-create/',
            {
            'title': ['hello23'],
            'body': ['<p>hdhh</p>'],
            'cid': ['1'],
            'state':['created'],
            'gid':['1'],
            'username':['tester'],
            'name':['collaboration-system'],
            'reply_to':['2'],
            'object_pk':['2'],
            'role':['author'],
            'status':['add']
            })
        request1.META['HTTP_USER_AGENT']='Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0'
        request1.META['SERVER_NAME']='fbbc375ca6a1'
        request1.META['HTTP_REFERER']='http://localhost:8000/community-article-create/'
        request1.META['HTTP_ACCEPT_LANGUAGE']='en-GB,en;q=0.5'
        request1.META['REMOTE_ADDR']='172.19.0.1'
        request1.COOKIES['sessionid']='mcle7sile4a6dhfdcxtyampo0kjo0c0e'
        self.data1={}
        self.data1['request']=request1
        self.data1['view_func']=None
        self.data1['view_args']=None
        self.data1['view_kwargs']={'pk':1, 'username':'tester'}
        request2=factory.post('/comment/post',{})
        request2.META['SERVER_NAME']=None
        request2.META['REMOTE_ADDR']=None
        self.data2={}
        self.data2['request']=request2
        self.data2['view_func']=None
        self.data2['view_args']=None
        self.data2['view_kwargs']={}

    def tearDown(self):
        pass

    def test_process_user_agent(self):
        self.assertEqual(logprocess.process_user_agent(self.data1),'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0')
        self.assertEqual(logprocess.process_user_agent(self.data2),"")

    def test_process_server_host(self):
        self.assertEqual(logprocess.process_server_host(self.data1),'fbbc375ca6a1')
        self.assertEqual(logprocess.process_server_host(self.data2),"")

    def test_process_referer(self):
        self.assertEqual(logprocess.process_referer(self.data1),'http://localhost:8000/community-article-create/')
        self.assertEqual(logprocess.process_referer(self.data2),"")

    def test_process_accept_language(self):
        self.assertEqual(logprocess.process_accept_language(self.data1),'en-GB,en;q=0.5')
        self.assertEqual(logprocess.process_accept_language(self.data2),"")

    def test_process_session_id(self):
        self.assertEqual(logprocess.process_session_id(self.data1),'mcle7sile4a6dhfdcxtyampo0kjo0c0e')
        self.assertEqual(logprocess.process_session_id(self.data2),"")

    def test_process_host_ip(self):
        self.assertEqual(logprocess.process_host_ip(self.data1),'172.19.0.1')
        self.assertEqual(logprocess.process_host_ip(self.data2),"")

    def test_process_path_info(self):
        self.assertEqual(logprocess.process_path_info(self.data1),'/community-article-create/')
        self.assertEqual(logprocess.process_path_info(self.data2),'/comment/post')

    def test_process_method(self):
        self.assertEqual(logprocess.process_method(self.data1),'POST')
        self.assertEqual(logprocess.process_method(self.data2),'POST')

    '''
    def test_process_user_info(self):
        self.assertEqual(logprocess.process_user_info(self.data1),--)
        self.assertEqual(logprocess.process_user_info(self.data2),--)
   '''

    def test_process_community_info(self):
        self.assertEqual(logprocess.process_community_info(self.data1),1)
        self.assertEqual(logprocess.process_community_info(self.data2),"")

    def test_process_group_info(self):
        self.assertEqual(logprocess.process_group_info(self.data1),1)
        self.assertEqual(logprocess.process_group_info(self.data2),"")

    def test_process_article_info(self):
        self.assertEqual(logprocess.process_article_info(self.data1),1)
        self.assertEqual(logprocess.process_article_info(self.data2),"")
    '''
    def test_process_time_stamp(self):
        self.assertEqual(logprocess.process_time_stamp(self.data1),--)
        self.assertEqual(logprocess.process_time_stamp(self.data2),--)
    '''

    def test_proces_attach_event_source(self):
        self.assertEqual(logprocess.proces_attach_event_source(self.data1),'server')
        self.assertEqual(logprocess.proces_attach_event_source(self.data2),'server')

    def test_process_article_state(self):
        self.assertEqual(logprocess.process_article_state(self.data1),'created')
        self.assertEqual(logprocess.process_article_state(self.data2),"")

    def test_process_cid(self):
        self.assertEqual(logprocess.process_cid(self.data1),'1')
        self.assertEqual(logprocess.process_cid(self.data2),"")

    def test_process_gid(self):
        self.assertEqual(logprocess.process_gid(self.data1),'1')
        self.assertEqual(logprocess.process_gid(self.data2),"")

    def test_process_username_from_request(self):
        self.assertEqual(logprocess.process_username_from_request(self.data1),'tester')
        self.assertEqual(logprocess.process_username_from_request(self.data2),"")

    def test_process_username_info(self):
        self.assertEqual(logprocess.process_username_info(self.data1),'tester')
        self.assertEqual(logprocess.process_username_info(self.data2),"")

    def test_process_coursename_info(self):
        self.assertEqual(logprocess.process_coursename_info(self.data1),'collaboration-system')
        self.assertEqual(logprocess.process_coursename_info(self.data2),"")

    def test_process_course_info(self):
        self.assertEqual(logprocess.process_course_info(self.data1),1)
        self.assertEqual(logprocess.process_course_info(self.data2),"")

    def test_process_post_community_name(self):
        self.assertEqual(logprocess.process_post_community_name(self.data1),'collaboration-system')
        self.assertEqual(logprocess.process_post_community_name(self.data2),"")

    def test_process_comment_reply_to(self):
        self.assertEqual(logprocess.process_comment_reply_to(self.data1),'2')
        self.assertEqual(logprocess.process_comment_reply_to(self.data2),"")

    def test_process_comment_object_pk(self):
        self.assertEqual(logprocess.process_comment_object_pk(self.data1),'2')
        self.assertEqual(logprocess.process_comment_object_pk(self.data2),"")

    def test_process_post_group_name(self):
        self.assertEqual(logprocess.process_post_group_name(self.data1),'collaboration-system')
        self.assertEqual(logprocess.process_post_group_name(self.data2),"")

    def test_process_manage_group_role(self):
        self.assertEqual(logprocess.process_manage_group_role(self.data1),'author')
        self.assertEqual(logprocess.process_manage_group_role(self.data2),"")

    def test_process_manage_group_status(self):
        self.assertEqual(logprocess.process_manage_group_status(self.data1),'add')
        self.assertEqual(logprocess.process_manage_group_status(self.data2),"")
'''
if __name__ == '__main__':
    unittest.main()
'''
