from django.core.urlresolvers import reverse
from django.urls import resolve
from django.test import TestCase
from Community.views import community_view
from .models import Community


class communityviewtest(TestCase):
	def test_community_view_success_status_code(self):
		url = reverse('community_view', kwargs={'pk': 1})
		response =self.client.get(url)
		self.assertEquals(response.status_code, 200)
	
