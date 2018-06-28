'''
  unit testing of handlers module
'''
from django.test import TestCase
from ..main import handlers

class SimpleTest(TestCase):
	def setUp(self):
		self.data1 = {
		     'test_case_1' : {
		         'input' : {
		             'state' : ['save']
		         },
		         'output' : 'article_edited'
		     },

		     'test_case_2' : {
		          'input' : {
		              'state' : ['visible']
		          },
		          'output' : 'article_visible'
		     },

		     'test_case_3' : {
		          'input' : {
		              'state' : ['private']
		          },
		          'output' : 'article_private'
		     },

		     'test_case_4' : {
		          'input' : {
		               'state' : ['public']
		          },
		          'output' : 'article_public'
		     },

		     'test_case_5' : {
		          'input' : {
		               'state' : ['publishable']
		          },
		          'output' : 'article_publishable'
		     },

		     'test_case_6' : {
		          'input' : {
		              'state' : ['publish']
		          },
		          'output' : 'article_published'
		     },

		     'test_case_7' : {
		          'input' : {
		               'state' : ['random']
		          },
		          'output' : None
		     }
		}

		self.data2 = {
             'test_case_1' : {
                  'input' : {
                       'status' : ['1']
                  },
                  'output' : 'article_create'
             },

             'test_case_2' : {
                   'input' : {
                         'status' : ['0']
                   },
                   'output' : None
             }
		}

	def test_article_event_type(self):
		for key in self.data1:
			self.assertEqual(handlers.article_event_type(self.data1[key]['input']),self.data1[key]['output'])

	def  test_article_create_handler(self):
		for  key  in self.data2:
			self.assertEqual(handlers.article_create_handler(self.data2[key]['input']),self.data2[key]['output'])
			
