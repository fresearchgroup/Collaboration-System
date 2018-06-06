# Create your tests here.
from django.core.urlresolvers import reverse
from django.urls import resolve
from django.test import TestCase
from django.contrib.auth.models import User
from .views import display_communities, request_community_creation, create_community, community_view, community_subscribe, community_unsubscribe
from .models import Community, RequestCommunityCreation, CommunityArticles, CommunityGroups

class DisplayCommunityTest(TestCase):
    def test_display_community_view_status_code(self):
        url = reverse('display_communities')
        response = self.client.get(url)
        self.assertEquals(response.status_code, 200)

    def test_display_communities_url_resloves_display_communities_view(self):
    	view = resolve('/communities/')
    	self.assertEquals(view.func, display_communities)


class CommunityViewTest(TestCase):
	def community_view_success_status_code(self):
		url = reverse('community_view', kwargs={'pk': 1})
		response =self.client.get(url)
		self.assertEquals(response.status_code, 200)

	def test_community_view_url_resolves_community_view(self):
		view = resolve('/community-view/1/')
		self.assertEquals(view.func, community_view)


class CommunitySubscribeTest(TestCase):
	def test_community_subscribe_valid_post(self):
		url = reverse('community_subscribe')
		data = {
			'cid': '1'
		}
		response = self.client.post(url, data)
		self.assertFalse(Community.objects.exists())

	def test_community_subscribe_url_resolves_community_subscribe_view(self):
		view = resolve('/community-subscribe/')
		self.assertEquals(view.func, community_subscribe)


class CommunityUnsubscribeTest(TestCase):
	def test_community_unsubscribe_valid_post(self):
		url = reverse('community_unsubscribe')
		data = {
			'cid': '1'
		}
		response = self.client.post(url, data)
		self.assertFalse(Community.objects.exists())

	def test_community_unsubscribe_url_resolves_community_unsubscribe_view(self):
		view = resolve('/community-unsubscribe/')
		self.assertEquals(view.func, community_unsubscribe)


class CommunityArticleCreateTest(TestCase):
	def test_community_article_create_valid_post(self):
		url = reverse('community_article_create')
		data = {
			'cid': '1'
		}
		response = self.client.post(url, data)
		self.assertFalse(CommunityArticles.objects.exists())


class CommunityGroupTest(TestCase):
	def test_community_group_valid_post(self):
		url = reverse('community_group')
		data = {
			'cid': '1'
		}
		response = self.client.post(url, data)
		self.assertFalse(CommunityGroups.objects.exists())


class RequestCommunityCreationTest(TestCase):
	def test_request_community_creation_status(self):
		url = reverse('request_community_creation')
		self.response = self.client.get(url)
		self.assertEquals(self.response.status_code, 302)

	def test_request_community_creation_valid_post(self):
		url = reverse('request_community_creation')
		data = {
			'name': 'Indian Festivals',
			'category': 'festival'
		}
		response = self.client.post(url, data)
		self.assertFalse(RequestCommunityCreation.objects.exists())

	def test_request_community_creation_url_resolves_request_community_creation_view(self):
		view = resolve('/request_community_creation/')
		self.assertEquals(view.func, request_community_creation)


class HandleCommunityCreationRequestsTest(TestCase):
	def test_handle_community_creation_requests_valid_post(self):
		url = reverse('handle_community_creation_requests')
		data = {
			'name': 'Indian Festivals',
			'category': 'festival'
		}
		response = self.client.post(url, data)
		self.assertFalse(Community.objects.exists())


class ManageCommunityTest(TestCase):
	def test_manage_community_status(self):
		url = reverse('manage_community', kwargs={'pk': 1})
		self.response = self.client.get(url)
		self.assertEquals(self.response.status_code, 302)

	def test_manage_community_valid_post(self):
		url = reverse('manage_community', kwargs={'pk': 1})
		data = {
			'name': 'Indian Festivals',
			'category': 'festival'
		}
		response = self.client.post(url, data)
		self.assertFalse(Community.objects.exists())


class UpdateCommunityInfoTest(TestCase):
	def test_update_community_info_valid_post(self):
		url = reverse('update_community_info', kwargs={'pk': 2})
		data = {
			'name': 'Indian Festivals',
			'category': 'festival'
		}
		response = self.client.post(url, data)
		self.assertFalse(Community.objects.exists())


class CreateCommunityTest(TestCase):
	def test_create_community_status(self):
		url = reverse('create_community')
		response = self.client.get(url)
		self.assertEquals(response.status_code, 302)

	def test_create_community_valid_post(self):
		url = reverse('create_community')
		data = {
			'name': 'Indian Festivals',
			'category': 'festival'
		}
		response = self.client.post(url, data)
		self.assertFalse(Community.objects.exists())

	def test_create_community_url_resolves_request_community_view(self):
		view = resolve('/create_community/')
		self.assertEquals(view.func, create_community)
