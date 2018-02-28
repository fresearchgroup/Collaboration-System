from django.test import TestCase
class ArticleViewsTestCase(TestCase):
    def test_index(self):
        resp = self.client.get('/articles/')
        self.assertEqual(resp.status_code,200)
        
        

# Create your tests here.
