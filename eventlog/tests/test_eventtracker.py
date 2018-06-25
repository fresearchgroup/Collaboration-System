'''
    Unit Test cases for Eventtracker.py module
'''
from ..main.eventtracker import EventTracker
from django.test import RequestFactory,TestCase
from django.contrib.auth import authenticate
from django.contrib.auth.models import User

class TestEventTracker(TestCase):

    def setUp(self):
        factory=RequestFactory()

        self.tracker=EventTracker()

        request=factory.get('/community-view/1/',{})
        request.META['HTTP_USER_AGENT']='Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:60.0) Gecko/20100101 Firefox/60.0'
        request.META['SERVER_NAME']='fbbc375ca6a1'
        request.META['HTTP_REFERER']=''
        request.META['HTTP_ACCEPT_LANGUAGE']='en-GB,en;q=0.5'
        request.META['REMOTE_ADDR']='172.19.0.1'
        request.COOKIES['sessionid']='mcle7sile4a6dhfdcxtyampo0kjo0c0e'

        user = User.objects.create_user(username='tester', email='tester@gmail.com', password='tester@123')
        user.save()
        user = authenticate(username='tester', password='tester@123')
        request.user = user
        request.user.id=1

        self.data={}
        self.data['request']=request
        self.data['view_func']=None
        self.data['view_args']=None
        self.data['view_kwargs']={ 'pk':'1' }

    def tearDown(self):
        pass

    def test_sendRequestData(self):
        self.tracker.sendRequestData(self.data)
        if(len(self.tracker.bucket)==1 and self.tracker.bucket[0]==self.data):
            self.assertEqual(True,True)
        else:
            self.assertEqual(True,False)
