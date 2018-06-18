'''
    Unit Test cases for Eventlogger.py module
'''
from ..main import eventlogger as store
from django.test import RequestFactory,TestCase
from django.contrib.auth import authenticate
from django.contrib.auth.models import User

class TestEventlogger(TestCase):
    def setUp(self):
        factory=RequestFactory()

        request=factory.get('/community-view/1/',{})
        request.META['HTTP_USER_AGENT']='Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0'
        request.META['SERVER_NAME']='fbbc375ca6a1'
        request.META['HTTP_REFERER']=''
        request.META['HTTP_ACCEPT_LANGUAGE']='en-GB,en;q=0.5'
        request.META['REMOTE_ADDR']='172.19.0.1'
        request.COOKIES['sessionid']='mcle7sile4a6dhfdcxtyampo0kjo0c0e'
        self.data={}
        self.data={}
        self.data['request']=request
        self.data['view_func']=None
        self.data['view_args']=None
        self.data['view_kwargs']={ 'pk':'1' }

        user = User.objects.create_user(username='tester', email='tester@gmail.com', password='tester@123')
        user.save()
        user = authenticate(username='tester', password='tester@123')
        request.user = user
        request.user.id=1

    def tearDown(self):
        pass

    def test_create_log(self):
        flag=0
        output={
            'user-agent': 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0',
            'ip-address': '172.19.0.1',
            'server-host': 'fbbc375ca6a1',
            'referer': '',
            'accept-language': 'en-GB,en;q=0.5',
            'session-id': 'mcle7sile4a6dhfdcxtyampo0kjo0c0e',
            'path-info': '/community-view/1/',
            'event-source': 'server',
            'user-id': 1,
            'event_name': 'event.community.view',
            'event': { 'community-id': '1' }
        }
        dic=store.create_log('event.community.view',self.data)
        for key in list(output.keys()):
            if(output[key]==dic[key]):
                flag=1
            else:
                flag=0
                break
        if(flag==0):
            self.assertEqual(True,False)
        else:
            self.assertEqual(True,True)
