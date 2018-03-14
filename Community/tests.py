from django.core.urlresolvers import reverse
from django.urls import resolve
from django.test import TestCase
from django.contrib.auth.models import User
from .views import display_communities, request_community_creation, create_community, community_view
from .models import Community, RequestCommunityCreation

class DisplayCommunityTest(TestCase):
    def test_display_community_view_status_code(self):
        url = reverse('display_communities')
        response = self.client.get(url)
        self.assertEquals(response.status_code, 200)

    
class RequestCommunityCreationTest(TestCase):
	def test_request_community_creation_status(self):
		url = reverse('request_community_creation')
		response = self.client.get(url)
		self.assertEquals(response.status_code, 302)

	def test_request_community_creation_valid_post(self):
		url = reverse('request_community_creation')
		data = {
			'name': 'Indian Festivals',
			'category': 'festival'
		}
		response = self.client.post(url, data)
		self.assertFalse(RequestCommunityCreation.objects.exists())

	#def test_request_community_creation_url_resolves_request_community_creation_view(self):
	#	view = resolve('request_community_creation/')
	#	self.assertEquals(view.func, request_community_creation)   


class CreateCommunityTest(TestCase):
	def test_create_community_status(self):
		url = reverse('create_community')
		response = self.client.get(url)
		self.assertEquals(response.status_code, 302)



class communityviewtest(TestCase):
	def community_view_success_status_code(self):
		url = reverse('community_view', kwargs={'pk': 1})
		response =self.client.get(url)
		self.assertEquals(response.status_code, 200)
	
		
	#def test_community_view_url_resolves_community_view(self):
	#	view = resolve('community-view/1/')
	#	self.assertEquals(view.func, community_view)

class manage_community(TestCase):
	
	def test_manage_community_valid_post(self):
		url = reverse('manage_community', kwargs={'pk': 2})
		data = {
			'name': 'Indian Festivals',
			'category': 'festival'
		}
		response = self.client.post(url, data)
		self.assertFalse(Community.objects.exists())
	
class handle_community_creation_requests(TestCase):
	
	def test_handle_community_creation_requests_valid_post(self):
		url = reverse('handle_community_creation_requests')
		data = {
			'name': 'Indian Festivals',
			'category': 'festival'
		}
		response = self.client.post(url, data)
		self.assertFalse(Community.objects.exists())


class update_community_info(TestCase):
	
	def test_update_community_info_valid_post(self):
		url = reverse('update_community_info', kwargs={'pk': 2})
		data = {
			'name': 'Indian Festivals',
			'category': 'festival'
		}
		response = self.client.post(url, data)
		self.assertFalse(Community.objects.exists())
