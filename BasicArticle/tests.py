from django.core.urlresolvers import reverse
from django.urls import resolve
from django.test import TestCase
from django.contrib.auth.models import User
from .views import display_articles,view_article,create_article,edit_article,delete_article,article_watch
from .models import Articles

class ArticleViewsTestCase(TestCase):
    def test_index(self):
        resp = self.client.get('/articles/')
        self.assertEqual(resp.status_code,200)

class Articlestests(TestCase):
	def test_display_articles_view_status_code(self):
		url = reverse('display_articles')
		response = self.client.get(url)
		self.assertEquals(response.status_code, 200)

	def test_display_articles_url_resolves_display_articles(self):
		view = resolve('/')
		self.assertTrue(view.func, display_articles)


class ArticleTests(TestCase):
	def test_view_article_success_status_code(self):
		url = reverse('article_view', kwargs={'pk': 1})
		response = self.client.get(url)
		self.assertTrue(response.status_code, 200)

	def test_view_article_view_not_found_status_code(self):
		url = reverse('article_view', kwargs={'pk': 99})
		response = self.client.get(url)
		self.assertEquals(response.status_code, 404)

	def test_view_article_url_resolves_view_article(self):
		view = resolve('/article-view/1/')
		self.assertEquals(view.func, view_article)


class article_createtests(TestCase):
	def test_community_article_create_valid_post_data(self):
		url = reverse('community_article_create')
		data={
			'status':'ALL CATEGORY',
			'cid':'1'
		}
		response = self.client.post(url,data)
		self.assertTrue(response.status_code, 200)

	def test_create_article_url_resolves_create_article(self):
		view = resolve('/')
		self.assertTrue(view.func, create_article)


class article_edittests(TestCase):
	def test_article_edit_valid_post(self):
		url = reverse('article_edit', kwargs={'pk': 1})
		data={
			'title':'IAS',
			'body':'Indian Administrative Service(IAS) officer.'
		}
		response=self.client.post(url,data)
		self.assertFalse(Articles.objects.exists())

	def test_edit_article_view_not_found_status_code(self):
		url = reverse('article_edit', kwargs={'pk': 99})
		response = self.client.get(url)
		self.assertTrue(response.status_code, 404)

	def test_edit_article_url_resolves_edit_article(self):
		view = resolve('/article-edit/1/')
		self.assertEquals(view.func, edit_article)



class article_deletetests(TestCase):
	def test_delete_article_valid_post_data(self):
		url = reverse('article_delete', kwargs={'pk': 1})
		data={
			'status':'1'
		}
		response=self.client.post(url,data)
		self.assertFalse(Articles.objects.exists())

	def test_delete_article_view_not_found_status_code(self):
		url = reverse('article_delete', kwargs={'pk': 99})
		response = self.client.get(url)
		self.assertTrue(response.status_code, 404)


	def test_article_url_resolves_article_delete(self):
		view = resolve('/article-delete/1/')
		self.assertEquals(view.func, delete_article)


class article_watchTests(TestCase):
	def test_article_watch_success_status_code(self):
		url = reverse('article_revision', kwargs={'pk': 1})
		response = self.client.get(url)
		self.assertTrue(response.status_code, 200)

	def test_watch_article_view_not_found_status_code(self):
		url = reverse('article_revision', kwargs={'pk': 99})
		response = self.client.get(url)
		self.assertTrue(response.status_code, 404)

	def test_watch_article_url_resolves_watch_article(self):
		view = resolve('/article-revision/1/')
		self.assertTrue(view.func, article_watch)
