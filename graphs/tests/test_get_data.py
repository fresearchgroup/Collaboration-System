from django.test import TestCase
from unittest import mock
from graphs import get_data
import requests

class TestClassDummy:
    
    def json(self):
        return {
			'status code': 200, 
			'total hits': 3, 
			'result': [
				{
					'path-info': '/community-view/1/', 
					'session-id': 't6puazvyf6atfpb47ht189cfotxm7m6s', 
					'time-stamp': '2018-06-15 06:58:45', 
					'event': {'community-id': '1'}, 
					'accept-language': 'en-GB,en-US;q=0.9,en;q=0.8', 
					'server-host': 'a3878831375c', 
					'@timestamp': '2018-06-15T06:58:45.858Z', 
					'referer': 'http://localhost:8000/group-view/1/', 
					'host': '172.18.0.6', 
					'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36', 
					'headers': {
						'http_version': 'HTTP/1.1', 
						'request_uri': '/', 'http_accept': '*/*', 
						'http_host': 'logstash:5000', 
						'http_accept_encoding': 'gzip, deflate', 
						'content_length': '512', 'request_path': '/', 
						'request_method': 'PUT', 'content_type': 'application/json', 
						'http_user_agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', 
						'http_connection': 'keep-alive'
					}, 
					'user-id': 2, 
					'@version': '1', 
					'event_name': 'event.community.view', 
					'ip-address': '172.18.0.1', 
					'event-source': 'server'
				}, 
				{
					'path-info': '/community-view/1/', 
					'session-id': 't6puazvyf6atfpb47ht189cfotxm7m6s', 
					'time-stamp': '2018-06-15 06:58:45', 
					'event': {'community-id': '1'}, 
					'accept-language': 'en-GB,en-US;q=0.9,en;q=0.8', 
					'server-host': 'a3878831375c', 
					'@timestamp': '2018-06-15T06:58:45.858Z', 
					'referer': 'http://localhost:8000/group-view/1/', 
					'host': '172.18.0.6', 
					'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36', 
					'headers': {
						'http_version': 'HTTP/1.1', 
						'request_uri': '/', 'http_accept': '*/*', 
						'http_host': 'logstash:5000', 
						'http_accept_encoding': 'gzip, deflate', 
						'content_length': '512', 'request_path': '/', 
						'request_method': 'PUT', 'content_type': 'application/json', 
						'http_user_agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', 
						'http_connection': 'keep-alive'
					}, 
					'user-id': 2, 
					'@version': '1', 
					'event_name': 'event.community.view', 
					'ip-address': '172.18.0.1', 
					'event-source': 'server'
				}, 
				{
					'path-info': '/community-view/1/', 
					'session-id': 't6puazvyf6atfpb47ht189cfotxm7m6s', 
					'time-stamp': '2018-06-17 06:58:45', 
					'event': {'community-id': '1'}, 
					'accept-language': 'en-GB,en-US;q=0.9,en;q=0.8', 
					'server-host': 'a3878831375c', 
					'@timestamp': '2018-06-15T06:58:45.858Z', 
					'referer': 'http://localhost:8000/group-view/1/', 
					'host': '172.18.0.6', 
					'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36', 
					'headers': {
						'http_version': 'HTTP/1.1', 
						'request_uri': '/', 'http_accept': '*/*', 
						'http_host': 'logstash:5000', 
						'http_accept_encoding': 'gzip, deflate', 
						'content_length': '512', 'request_path': '/', 
						'request_method': 'PUT', 'content_type': 'application/json', 
						'http_user_agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', 
						'http_connection': 'keep-alive'
					}, 
					'user-id': 2, 
					'@version': '1', 
					'event_name': 'event.community.view', 
					'ip-address': '172.18.0.1', 
					'event-source': 'server'
				}
			]
		}



class TestParse(TestCase):

	def setUp(self):
		self.data = [
		{
			'path-info': '/community-view/1/', 
			'session-id': 't6puazvyf6atfpb47ht189cfotxm7m6s', 
			'time-stamp': '2018-06-15 06:58:45', 
			'event': {'community-id': '1'}, 
			'accept-language': 'en-GB,en-US;q=0.9,en;q=0.8', 
			'server-host': 'a3878831375c', 
			'@timestamp': '2018-06-15T06:58:45.858Z', 
			'referer': 'http://localhost:8000/group-view/1/', 
			'host': '172.18.0.6', 'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36', 
			'headers': {
				'http_version': 'HTTP/1.1', 
				'request_uri': '/', 
				'http_accept': '*/*', 
				'http_host': 'logstash:5000', 
				'http_accept_encoding': 'gzip, deflate', 
				'content_length': '512', 
				'request_path': '/', 
				'request_method': 'PUT', 
				'content_type': 'application/json', 
				'http_user_agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', 
				'http_connection': 'keep-alive'
			}, 
			'user-id': 2, 
			'@version': '1', 
			'event_name': 'event.community.view', 
			'ip-address': '172.18.0.1', 
			'event-source': 'server'
		},
		{
			'path-info': '/community-view/1/', 
			'session-id': 't6puazvyf6atfpb47ht189cfotxm7m6s', 
			'time-stamp': '2018-06-15 07:52:01', 
			'event': {'community-id': '1'}, 
			'accept-language': 'en-GB,en-US;q=0.9,en;q=0.8', 
			'server-host': 'a3878831375c', 
			'@timestamp': '2018-06-15T06:58:45.858Z', 
			'referer': 'http://localhost:8000/group-view/1/', 
			'host': '172.18.0.6', 'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36', 
			'headers': {
				'http_version': 'HTTP/1.1', 
				'request_uri': '/', 
				'http_accept': '*/*', 
				'http_host': 'logstash:5000', 
				'http_accept_encoding': 'gzip, deflate', 
				'content_length': '512', 
				'request_path': '/', 
				'request_method': 'PUT', 
				'content_type': 'application/json', 
				'http_user_agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', 
				'http_connection': 'keep-alive'
			}, 
			'user-id': 2, 
			'@version': '1', 
			'event_name': 'event.community.view', 
			'ip-address': '172.18.0.1', 
			'event-source': 'server'
		}
	]

		self.result = [['2018', '06', '15', '06', '58', '45'],['2018', '06', '15', '07', '52', '01']]

	def test_parse(self):
		self.assertEqual(get_data.parse(self.data),self.result)

class TestGetDate(TestCase):

	def setUp(self):
		self.parse_date = [['2018', '06', '15', '06', '58', '45'],['2018', '06', '14', '07', '52', '01']]
		self.result = [15,14]

	def test_get_date(self):
		self.assertEqual(get_data.get_date(self.parse_date),self.result)

class TestDistinct(TestCase):

	def setUp(self):
		self.date_list = [2,2,4,1,6,6,6,6,2]
		self.result = [1,2,4,6]

	def test_find_distinct(self):
		self.assertEqual(get_data.find_distinct(self.date_list),self.result)

class TestFrequency(TestCase):

	def setUp(self):
		self.date_list = [2,2,4,1,6,6,6,6,2]
		self.date_list.sort()
		self.result = [1,3,1,4]

	def test_frequency(self):
		self.assertEqual(get_data.find_frequency(self.date_list),self.result)

class TestCreateDataPlot(TestCase):

	def setUp(self):
		self.distinct = [1,2,4,6]
		self.frequency = [1,3,1,4]
		self.result = [0,1,3,0,1,0,4]

	def test_create_data_plot(self):
		self.assertEqual(get_data.create_plotdata(self.distinct,self.frequency),self.result)

class TestView(TestCase):

	def setUp(self):
		self.articleid = 2
		self.communityid = 1
		self.article = 'article'
		self.community = 'community'
		self.commresult = [[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 1]]
		self.articleresult = []
                #self.requests = requests.get('http://localhost:8000/')

	@mock.patch('requests.get')
	@mock.patch.object(requests.models.Response,'json')
	def test_view(self,testfunc,func):
		func.return_value = TestClassDummy()
		testfunc.return_value = {
			'status code': 200, 
			'total hits': 3, 
			'result': [
				{
					'path-info': '/community-view/1/', 
					'session-id': 't6puazvyf6atfpb47ht189cfotxm7m6s', 
					'time-stamp': '2018-06-15 06:58:45', 
					'event': {'community-id': '1'}, 
					'accept-language': 'en-GB,en-US;q=0.9,en;q=0.8', 
					'server-host': 'a3878831375c', 
					'@timestamp': '2018-06-15T06:58:45.858Z', 
					'referer': 'http://localhost:8000/group-view/1/', 
					'host': '172.18.0.6', 
					'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36', 
					'headers': {
						'http_version': 'HTTP/1.1', 
						'request_uri': '/', 'http_accept': '*/*', 
						'http_host': 'logstash:5000', 
						'http_accept_encoding': 'gzip, deflate', 
						'content_length': '512', 'request_path': '/', 
						'request_method': 'PUT', 'content_type': 'application/json', 
						'http_user_agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', 
						'http_connection': 'keep-alive'
					}, 
					'user-id': 2, 
					'@version': '1', 
					'event_name': 'event.community.view', 
					'ip-address': '172.18.0.1', 
					'event-source': 'server'
				}, 
				{
					'path-info': '/community-view/1/', 
					'session-id': 't6puazvyf6atfpb47ht189cfotxm7m6s', 
					'time-stamp': '2018-06-15 06:58:45', 
					'event': {'community-id': '1'}, 
					'accept-language': 'en-GB,en-US;q=0.9,en;q=0.8', 
					'server-host': 'a3878831375c', 
					'@timestamp': '2018-06-15T06:58:45.858Z', 
					'referer': 'http://localhost:8000/group-view/1/', 
					'host': '172.18.0.6', 
					'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36', 
					'headers': {
						'http_version': 'HTTP/1.1', 
						'request_uri': '/', 'http_accept': '*/*', 
						'http_host': 'logstash:5000', 
						'http_accept_encoding': 'gzip, deflate', 
						'content_length': '512', 'request_path': '/', 
						'request_method': 'PUT', 'content_type': 'application/json', 
						'http_user_agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', 
						'http_connection': 'keep-alive'
					}, 
					'user-id': 2, 
					'@version': '1', 
					'event_name': 'event.community.view', 
					'ip-address': '172.18.0.1', 
					'event-source': 'server'
				}, 
				{
					'path-info': '/community-view/1/', 
					'session-id': 't6puazvyf6atfpb47ht189cfotxm7m6s', 
					'time-stamp': '2018-06-17 06:58:45', 
					'event': {'community-id': '1'}, 
					'accept-language': 'en-GB,en-US;q=0.9,en;q=0.8', 
					'server-host': 'a3878831375c', 
					'@timestamp': '2018-06-15T06:58:45.858Z', 
					'referer': 'http://localhost:8000/group-view/1/', 
					'host': '172.18.0.6', 
					'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36', 
					'headers': {
						'http_version': 'HTTP/1.1', 
						'request_uri': '/', 'http_accept': '*/*', 
						'http_host': 'logstash:5000', 
						'http_accept_encoding': 'gzip, deflate', 
						'content_length': '512', 'request_path': '/', 
						'request_method': 'PUT', 'content_type': 'application/json', 
						'http_user_agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', 
						'http_connection': 'keep-alive'
					}, 
					'user-id': 2, 
					'@version': '1', 
					'event_name': 'event.community.view', 
					'ip-address': '172.18.0.1', 
					'event-source': 'server'
				}
			]
		}
		self.assertEqual(get_data.view(self.communityid,self.community),self.commresult)
class TestParse(TestCase):

	def setUp(self):
		self.data = [
		{
			'path-info': '/community-view/1/', 
			'session-id': 't6puazvyf6atfpb47ht189cfotxm7m6s', 
			'time-stamp': '2018-06-15 06:58:45', 
			'event': {'community-id': '1'}, 
			'accept-language': 'en-GB,en-US;q=0.9,en;q=0.8', 
			'server-host': 'a3878831375c', 
			'@timestamp': '2018-06-15T06:58:45.858Z', 
			'referer': 'http://localhost:8000/group-view/1/', 
			'host': '172.18.0.6', 'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36', 
			'headers': {
				'http_version': 'HTTP/1.1', 
				'request_uri': '/', 
				'http_accept': '*/*', 
				'http_host': 'logstash:5000', 
				'http_accept_encoding': 'gzip, deflate', 
				'content_length': '512', 
				'request_path': '/', 
				'request_method': 'PUT', 
				'content_type': 'application/json', 
				'http_user_agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', 
				'http_connection': 'keep-alive'
			}, 
			'user-id': 2, 
			'@version': '1', 
			'event_name': 'event.community.view', 
			'ip-address': '172.18.0.1', 
			'event-source': 'server'
		},
		{
			'path-info': '/community-view/1/', 
			'session-id': 't6puazvyf6atfpb47ht189cfotxm7m6s', 
			'time-stamp': '2018-06-15 07:52:01', 
			'event': {'community-id': '1'}, 
			'accept-language': 'en-GB,en-US;q=0.9,en;q=0.8', 
			'server-host': 'a3878831375c', 
			'@timestamp': '2018-06-15T06:58:45.858Z', 
			'referer': 'http://localhost:8000/group-view/1/', 
			'host': '172.18.0.6', 'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.87 Safari/537.36', 
			'headers': {
				'http_version': 'HTTP/1.1', 
				'request_uri': '/', 
				'http_accept': '*/*', 
				'http_host': 'logstash:5000', 
				'http_accept_encoding': 'gzip, deflate', 
				'content_length': '512', 
				'request_path': '/', 
				'request_method': 'PUT', 
				'content_type': 'application/json', 
				'http_user_agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36', 
				'http_connection': 'keep-alive'
			}, 
			'user-id': 2, 
			'@version': '1', 
			'event_name': 'event.community.view', 
			'ip-address': '172.18.0.1', 
			'event-source': 'server'
		}
	]

		self.result = [['2018', '06', '15', '06', '58', '45'],['2018', '06', '15', '07', '52', '01']]

	def test_parse(self):
		self.assertEqual(get_data.parse(self.data),self.result)

class TestGetDate(TestCase):

	def setUp(self):
		self.parse_date = [['2018', '06', '15', '06', '58', '45'],['2018', '06', '14', '07', '52', '01']]
		self.result = [15,14]

	def test_get_date(self):
		self.assertEqual(get_data.get_date(self.parse_date),self.result)

class TestDistinct(TestCase):

	def setUp(self):
		self.date_list = [2,2,4,1,6,6,6,6,2]
		self.result = [1,2,4,6]

	def test_find_distinct(self):
		self.assertEqual(get_data.find_distinct(self.date_list),self.result)

class TestFrequency(TestCase):

	def setUp(self):
		self.date_list = [2,2,4,1,6,6,6,6,2]
		self.date_list.sort()
		self.result = [1,3,1,4]

	def test_frequency(self):
		self.assertEqual(get_data.find_frequency(self.date_list),self.result)

class TestCreateDataPlot(TestCase):

	def setUp(self):
		self.distinct = [1,2,4,6]
		self.frequency = [1,3,1,4]
		self.result = [0,1,3,0,1,0,4]

	def test_create_data_plot(self):
		self.assertEqual(get_data.create_plotdata(self.distinct,self.frequency),self.result)
