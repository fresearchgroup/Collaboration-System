from django.core.urlresolvers import reverse
from django.urls import resolve
from django.test import TestCase,TransactionTestCase
from django.contrib.auth.models import User
from . import views
from django.test.client import RequestFactory

class API(TestCase):

	def setup(self):
		self.factory = RequestFactory()
	
		self.user1 = User.objects.create(username="user1", password="pwd", email="example@example.com")
		self.user2 = User.objects.create(username="user2", password="pwd", email="example@example.com")
	
		self.comm = Community.objects.create(name='fake_community', desc='fake',image='/home/karthik/Downloads/index.jpg',category='fake', created_by=self.user1, tag_line='always fake',forum_link='jvajds')
	
		self.grp = Group.objects.create(name='fake_grp', desc='I am fake', image='/home/karthik/Downloads/index.jpg',visibility=True, created_by=self.user1)
	
		self.commgrp = CommunityGroups.objects.create(group=self.grp, user=self.user3, community=self.comm)
	
		self.draft=States.objects.create(name='draft')
		self.private = States.objects.create(name='private')
		self.visible=States.objects.create(name='visible')
		self.publishable=States.objects.create(name='publishable')
		self.publish=States.objects.create(name='publish')
	
		self.article1 = Articles.objects.create(title='fake_article1', body='abc', created_by=self.user1, state=self.visible)
		self.article2 = Articles.objects.create(title='fake_article2', body='abc', created_by=self.user1, state=self.visible)
		self.article3 = Articles.objects.create(title='fake_article3', body='abc', created_by=self.user1, state=self.visible)
		self.article4 = Articles.objects.create(title='fake_article4', body='abc', created_by=self.user1, state=self.visible)
		self.article5 = Articles.objects.create(title='fake_article5', body='abc', created_by=self.user1, state=self.visible)
		self.article6 = Articles.objects.create(title='fake_article6', body='abc', created_by=self.user1, state=self.visible)
	
		self.comm_article = CommunityArticles.objects.create(article=self.article1, community=self.comm, user=self.user1)
		self.comm_article = CommunityArticles.objects.create(article=self.article2, community=self.comm, user=self.user1)
		self.comm_article = CommunityArticles.objects.create(article=self.article3, community=self.comm, user=self.user1)
		self.comm_article = CommunityArticles.objects.create(article=self.article4, community=self.comm, user=self.user1)
		self.comm_article = CommunityArticles.objects.create(article=self.article5, community=self.comm, user=self.user1)
		self.comm_article = CommunityArticles.objects.create(article=self.article6, community=self.comm, user=self.user1)
	
	
	#def test_recommendationtest(self):
	#	request = initiate_get(self)
	#	response = view_article(request, pk)

	def setup_view(view,request,*args,**kwargs):
		view.request = request
		view.args = args
		view.kwargs = kwargs
		return view
	
	def test_recommendation(self):
		self.user1 = User.objects.create_superuser('myuser', 'myemail@test.com', password='pwd')
		url = reverse('article_view')
		request = self.factory.get(url)
		request.user = self.user1
		view = setup_view(get_Recommendations(),request)
		output = view.get(request)
		self.assertTrue(output)

		
