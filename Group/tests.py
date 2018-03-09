from django.core.urlresolvers import reverse
from django.urls import resolve
from django.test import TestCase
from .views import group_view ,group_article_create,group_subscribe
from .models import  Group ,GroupMembership ,GroupArticles

class Grouptest(TestCase):
    #def setUp(self):
       # Group.objects.create(name='Django', description='Django Group')
    def group_view_success_status_code(self):
        url = reverse('group_view', kwargs={'pk': 1})
        response = self.client.get(url)
        self.assertEquals(response.status_code, 200)

    def group_view_not_found_status_code(self):
        url = reverse('group_view', kwargs={'pk': 99})
        response = self.client.get(url)
        self.assertEquals(response.status_code, 404)

    def group_url_resolves_group_view(self):
        view = resolve('/group_view/1/')
        self.assertEquals(view.func, group_view)



class GrouparticleTests(TestCase):
	#def setUp(self):
	#	GroupArticles.objects.create(article='1', user='1', group='1')
	

    def group_article_create_not_found_status_code(self):
        url = reverse('group_article_create', kwargs={'pk': 99})
        response = self.client.get(url)
        self.assertEquals(response.status_code, 404)

    def group_article_create_url_resolves_group_article_create(self):
        view = resolve('/group_article_create/1/')
        self.assertEquals(view.func, group_article_create)

	#def group_article_create_success_status_code(self):
       # url = reverse('group_article_create', kwargs={'pk': 1})
       # response = self.client.get(url)
       # self.assertEquals(response.status_code, 200)



class Group_subscribetest(TestCase):
    #def setUp(self):
       # Group.objects.create(name='Django', description='Django Group')
    def group_subscribe_success_status_code(self):
        url = reverse('group_subscribe', kwargs={'pk': 1})
        response = self.client.get(url)
        self.assertEquals(response.status_code, 200)

    def group_subscribe_not_found_status_code(self):
        url = reverse('group_subscribe', kwargs={'pk': 99})
        response = self.client.get(url)
        self.assertEquals(response.status_code, 404)

   # def group_subscribe_url_resolves_group_subscribe(self):
#view = resolve('/group_view/1/')
      #  self.assertEquals(view.func, group_subscribe)



