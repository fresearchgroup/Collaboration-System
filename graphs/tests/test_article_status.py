from django.test import TestCase
from unittest import mock
from graphs import article_status
from BasicArticle.models import Articles
from Community.models import CommunityArticles, Community
from workflow.models import States
from django.contrib.auth.models import User

class TestExtractState(TestCase):

	def setUp(self):

		self.draft = States.objects.create(name = 'draft')
		self.publishable = States.objects.create(name = 'publishable')
		self.visible = States.objects.create(name = 'visible')
		self.published = States.objects.create(name = 'published')

		self.a1 = Articles.objects.create(title = 't1',state= self.draft)
		self.a2 = Articles.objects.create(title = 't2',state= self.visible)
		self.a3 = Articles.objects.create(title = 't3',state= self.publishable)
		self.a4 = Articles.objects.create(title = 't4',state= self.visible)
		self.list = [self.a1.id, self.a2.id, self.a3.id, self.a4.id]
		self.state = ['draft', 'publishable',  'visible', 'visible']

	def tearDown(self):
		self.a1.delete()
		self.a2.delete()
		self.a3.delete()
		self.a4.delete()

	def test_extract_state(self):
		self.assertEqual(article_status.extract_state(self.list),self.state)

class TestFrequency(TestCase):

	def setUp(self):
		self.state = ['draft', 'visible', 'visible', 'publishable']
		self.result = [1,2,1]

	def test_freq_state(self):
		self.assertEqual(article_status.freq_state(self.state),self.result)

class TestFindArticles(TestCase):

	def setUp(self):
		self.u1 =  User.objects.create_user(username= 'u1')
		self.u2 = User.objects.create_user(username = 'u2')
		self.a1 = Articles.objects.create(title = 't1', created_by = self.u1)
		self.a2 = Articles.objects.create(title = 't2', created_by = self.u1)
		self.a3 = Articles.objects.create(title = 't3', created_by = self.u2)
		self.a4 = Articles.objects.create(title = 't4', created_by = self.u1)
		self.u1results = [self.a1.id, self.a2.id, self.a4.id]
		self.u2results = [self.a3.id]

	def tearDown(self):
		self.u1.delete()
		self.u2.delete()
		self.a1.delete()
		self.a2.delete()
		self.a3.delete()
		self.a4.delete()

	def test_find_articles(self):
		self.assertEqual(article_status.find_articles(self.u1),self.u1results)
		self.assertEqual(article_status.find_articles(self.u2),self.u2results)

class TestLabels(TestCase):

	def setUp(self):
		self.article_state = ['draft', 'publishable',  'visible', 'visible']
		self.result = ['draft', 'publishable', 'visible']

	def test_labels(self):
		self.assertEqual(article_status.labels(self.article_state),self.result)

class TestCommunityArticles(TestCase):

	def setUp(self):
		self.a1 = Articles.objects.create(title = 't1')
		self.a2 = Articles.objects.create(title = 't2')
		self.a3 = Articles.objects.create(title = 't3')
		self.a4 = Articles.objects.create(title = 't4')

		self.c1 = Community.objects.create(name = 'c1')
		self.c2 = Community.objects.create(name = 'c2')

		self.u1 =  User.objects.create_user(username= 'u1')

		self.ca1 = CommunityArticles.objects.create(article = self.a1, community = self.c1, user = self.u1)
		self.ca2 = CommunityArticles.objects.create(article = self.a2, community = self.c1, user = self.u1)
		self.ca3 = CommunityArticles.objects.create(article = self.a3, community = self.c2, user = self.u1)
		self.ca4 = CommunityArticles.objects.create(article = self.a4, community = self.c1, user = self.u1)

		self.c1result = [self.a1.id,self.a2.id,self.a4.id]
		self.c2result = [self.a3.id]
	
	def tearDown(self):
		self.a1.delete()
		self.a2.delete()
		self.a3.delete()
		self.a4.delete()
		self.c1.delete()
		self.c2.delete()
		self.ca1.delete()
		self.ca2.delete()
		self.ca3.delete()
		self.ca4.delete()

	def test_community_articles(self):
		self.assertEqual(article_status.community_articles(self.c1.id),self.c1result)
		self.assertEqual(article_status.community_articles(self.c2.id),self.c2result)

class TestTopView(TestCase):

	def setUp(self):
		self.a1 = Articles.objects.create(title = 't1', views = 10)
		self.a2 = Articles.objects.create(title = 't2', views = 3)
		self.a3 = Articles.objects.create(title = 't3', views = 17)
		self.a4 = Articles.objects.create(title = 't4', views = 1)
		self.a5 = Articles.objects.create(title = 't5')
		self.a6 = Articles.objects.create(title = 't6', views = 19)
		self.article_list = [self.a1.id, self.a2.id, self.a3.id, self.a4.id, self.a5.id, self.a6.id]
		self.result = [[self.a6.views, self.a6.id], [self.a3.views, self.a3.id], [self.a1.views, self.a1.id], [self.a2.views, self.a2.id], [self.a4.views, self.a4.id]]

	def tearDown(self):
		self.a1.delete()
		self.a2.delete()
		self.a3.delete()
		self.a4.delete()

	def test_topfive(self):
		self.assertEqual(article_status.topfive(self.article_list),self.result)

class TestGetArticleName(TestCase):

	def setUp(self):
		self.a1 = Articles.objects.create(title = 't1')
		self.a2 = Articles.objects.create(title = 't2')
		self.a3 = Articles.objects.create(title = 't3')
		self.a4 = Articles.objects.create(title = 't4')
		self.article_list = [self.a1.id, self.a2.id, self.a3.id, self.a4.id] 
		self.result = [self.a1.title, self.a2.title, self.a3.title, self.a4.title]

	def tearDown(self):
		self.a1.delete()
		self.a2.delete()
		self.a3.delete()
		self.a4.delete()

	def test_get_article_name(self):
		self.assertEqual(article_status.get_article_name(self.article_list),self.result)