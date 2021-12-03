from django.core.urlresolvers import reverse
from django.urls import resolve
from django.test import TestCase
from .views import *
from graphs import get_data
from unittest import mock
# from eventlog.main.handlers import *


class ArticleDashboardTests(TestCase):

	@mock.patch.object(get_data ,"view")
	def test_view_article_dashboard_success_status_code(self,testfunc):
		testfunc.return_value = [[1,2,3,4,5,6,0]]
		url = reverse('article_dashboard', kwargs={'pk': 2})
		response = self.client.get(url)
		self.assertTrue(response.status_code, 200)

	@mock.patch.object(get_data ,"view")
	def test_view_article_dashboard_not_found_status_code(self,testfunc):
		testfunc.return_value = [[]]
		url = reverse('article_dashboard', kwargs={'pk': 999})
		response = self.client.get(url)
		self.assertEquals(response.status_code, 404)

	@mock.patch.object(get_data ,"view")
	def test_view_article_url_resolves_view_article(self,testfunc):
		testfunc.return_value = [[1,2,3,4,5,6,0]]
		view = resolve('/article-dashboard/2/')
		self.assertEquals(view.func, article_dashboard)

class CommunityDashboardTests(TestCase):

	@mock.patch.object(get_data ,"view")
	def test_view_community_dashboard_success_status_code(self,testfunc):
		testfunc.return_value = [[1,2,3,4,5,6,0]]
		url = reverse('community_dashboard', kwargs={'pk': 1})
		response = self.client.get(url)
		self.assertTrue(response.status_code, 200)

	@mock.patch.object(get_data ,"view")
	def test_view_community_dashboard_not_found_status_code(self,testfunc):
		testfunc.return_value = [[]]
		url = reverse('community_dashboard', kwargs={'pk': 999})
		response = self.client.get(url)
		self.assertEquals(response.status_code, 404)

	@mock.patch.object(get_data ,"view")
	def test_view_community_dashboard_url_resolves_view_a(self,testfunc):
		testfunc.return_value = [[1,2,3,4,5,6,0]]
		view = resolve('/community-dashboard/1/')
		self.assertEquals(view.func, community_dashboard)

class UserInsightDashboardTests(TestCase):

	@mock.patch.object(article_status ,"find_articles")
	def test_view_user_insight_dashboard_success_status_code(self,testfunc):
		testfunc.return_value = [1,2,3,4]
		url = reverse('user_dashboard')
		response = self.client.get(url)
		self.assertTrue(response.status_code, 200)

	@mock.patch.object(article_status ,"find_articles")
	def test_view_user_insight_url_resolves_view_article(self,testfunc):
		testfunc.return_value = [1,2,3,4]
		view = resolve('/user-insight-dashboard/')
		self.assertEquals(view.func, user_insight_dashboard)
