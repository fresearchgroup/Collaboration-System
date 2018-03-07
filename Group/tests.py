from django.core.urlresolvers import reverse
from django.urls import resolve
from django.test import TestCase
from .views import group_view
from .models import  Group ,GroupMembership ,GroupArticles

class grouptest(TestCase):
    #def setUp(self):
       # Group.objects.create(name='Django', description='Django Group')

    def test_board_topics_view_success_status_code(self):
        url = reverse('group-view', kwargs={'pk': 1})
        response = self.client.get(url)
        self.assertEquals(response.status_code, 200)

    #def test_board_topics_view_not_found_status_code(self):
       # url = reverse('', kwargs={'pk': 99})
       # response = self.client.get(url)
        #self.assertEquals(response.status_code, 404)

   # def test_board_topics_url_resolves_board_topics_view(self):
   #     view = resolve('/group_view/1/')
    #    self.assertEquals(view.func, board_topics)
