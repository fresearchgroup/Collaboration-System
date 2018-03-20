from django.core.urlresolvers import reverse
from django.urls import resolve
from django.test import TestCase
from .views import group_view ,group_article_create,group_subscribe
from .models import  Group ,GroupMembership ,GroupArticles
class Grouptest(TestCase):


    def test_group_subscribe_valid_post_data(self):
        url = reverse('group_subscribe')
        data = {
            'user':'kamleshsisodiya',
            'role':'author'
        }
        response = self.client.post(url, data)
        self.assertFalse(GroupMembership.objects.exists())


    def test_create_group_valid_post_data(self):
        url = reverse('community_group')
        data = {
            'name':'Education Centre',
            'desc':'this is for better education'
        }
        response = self.client.post(url, data)
        self.assertFalse(Group.objects.exists())



    def test_update_group_info_valid_post_data(self):
        url = reverse('update_group_info',kwargs={'pk': 1})
        data = {
            'name':'Education Centre',
            'desc':'this is for better education',
            'visibility': 'public'
        }
        response = self.client.post(url, data)
        self.assertFalse(Group.objects.exists())


    def test_group_unsubscribe_valid_post_data(self):
        url = reverse('group_unsubscribe')
        data = {
            'gid ':'1',
            'user':'kamleshsisodiya'
        }
        response = self.client.post(url, data)
        self.assertFalse(GroupMembership.objects.exists())

    def test_manage_group_valid_post_data(self):
        url = reverse('manage_group',kwargs={'pk': 2})
        data = {
            'user':'kamleshsisodiya',
            'role':'author'
        }
        response = self.client.post(url, data)
        self.assertFalse(GroupMembership.objects.exists())

    def test_group_article_create_valid_post_data(self):
        url = reverse('group_article_create')
        data={
        'gid':'1',
        'status':'publishable',
        'group':'Education Centre'
        }
        response = self.client.post(url, data)
        self.assertFalse(Group.objects.exists())

    def group_view_success_status_code(self):
        url = reverse('group_view', kwargs={'pk': 1})
        response = self.client.get(url)
        self.assertEquals(response.status_code, 200)


    def group_view_not_found_status_code(self):
        url = reverse('group_view', kwargs={'pk': 99})
        response = self.client.get(url)
        self.assertEquals(response.status_code, 404)




# Create your tests here.
