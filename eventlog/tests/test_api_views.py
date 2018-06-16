from django.test import TestCase
from unittest import mock
from ..api import views
from ..api import essearch
from rest_framework.test import APIClient
import json

class TestAPIView(TestCase):

    def setUp(self):
        self.rf = APIClient()
        self.result1 =  {
                "Status Code": 200,
                "total hits": 1,
                "result": [
                    {
                "event-source": "server",
                "server-host": "974ae49a5fc0",
                "event": {
                    "community-id": "1"
                },
                "@version": "1",
                "referer": "http://localhost:8000/login/?next=/community-view/1",
                "time-stamp": "2018-06-15 13:09:42",
                "accept-language": "en-US,en;q=0.9",
                "event_name": "event.community.view",
                "session-id": "5o61ux6e0n58d3myoc3z5ao6bds2xtqu",
                "path-info": "/community-view/1/",
                "ip-address": "172.18.0.1",
                "user-id": 1,
                "host": "172.18.0.6",
                "@timestamp": "2018-06-15T13:09:42.716Z",
                "user-agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.62 Safari/537.36",
                "headers": {
                        "request_path": "/",
                        "http_accept_encoding": "gzip, deflate",
                        "http_host": "logstash:5000",
                        "http_accept": "*/*",
                        "http_version": "HTTP/1.1",
                        "content_length": "516",
                        "content_type": "application/json",
                        "request_method": "PUT",
                        "request_uri": "/",
                        "http_user_agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36",
                        "http_connection": "keep-alive"
                        }
                    },
                ]
                }
        self.return_value1 = {
                "status": 200,
                "logs": [
                    {
                "event-source": "server",
                "server-host": "974ae49a5fc0",
                "event": {
                    "community-id": "1"
                },
                "@version": "1",
                "referer": "http://localhost:8000/login/?next=/community-view/1",
                "time-stamp": "2018-06-15 13:09:42",
                "accept-language": "en-US,en;q=0.9",
                "event_name": "event.community.view",
                "session-id": "5o61ux6e0n58d3myoc3z5ao6bds2xtqu",
                "path-info": "/community-view/1/",
                "ip-address": "172.18.0.1",
                "user-id": 1,
                "host": "172.18.0.6",
                "@timestamp": "2018-06-15T13:09:42.716Z",
                "user-agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.62 Safari/537.36",
                "headers": {
                        "request_path": "/",
                        "http_accept_encoding": "gzip, deflate",
                        "http_host": "logstash:5000",
                        "http_accept": "*/*",
                        "http_version": "HTTP/1.1",
                        "content_length": "516",
                        "content_type": "application/json",
                        "request_method": "PUT",
                        "request_uri": "/",
                        "http_user_agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36",
                        "http_connection": "keep-alive"
                        }
                    },
                ]
                }
        self.result2 = {
                "Status Code": 200,
                "total hits": 0,
                "result": []
                }
        self.return_value2 = {
                "status": 200,
                "logs": []
                }

        self.return_value3 = {
       "error": [
            404,
            "index_not_found_exception",
            {   
                "error": {
                    "root_cause": [
                        {
                            "type": "index_not_found_exception",
                            "reason": "no such index",
                            "resource.type": "index_or_alias",
                            "resource.id": "logs-1",
                            "index_uuid": "_na_",
                            "index": "logs-1"
                        }
                    ],
                    "type": "index_not_found_exception",
                    "reason": "no such index",
                    "resource.type": "index_or_alias",
                    "resource.id": "logs-1",
                    "index_uuid": "_na_",
                    "index": "logs-1"
                    },
                    "status": 404
                }
            ]
        }

        self.result3 ={
       "error": [
            404,
            "index_not_found_exception",
            {   
                "error": {
                    "root_cause": [
                        {
                            "type": "index_not_found_exception",
                            "reason": "no such index",
                            "resource.type": "index_or_alias",
                            "resource.id": "logs-1",
                            "index_uuid": "_na_",
                            "index": "logs-1"
                        }
                    ],
                    "type": "index_not_found_exception",
                    "reason": "no such index",
                    "resource.type": "index_or_alias",
                    "resource.id": "logs-1",
                    "index_uuid": "_na_",
                    "index": "logs-1"
                    },
                    "status": 404
                }
            ]
        }

    @mock.patch.object(essearch.SearchElasticSearch, 'search_elasticsearch')
    def test_get_user_id(self, func):
        func.return_value = self.return_value1
        cres = self.rf.get('/logapi/user/1/')
        self.assertEqual(cres.json(), self.result1)

    @mock.patch.object(essearch.SearchElasticSearch, 'search_elasticsearch')
    def test_get_event(self, func):
        func.return_value = self.return_value1
        cres = self.rf.get('/logapi/event/community/view/')
        self.assertEqual(cres.json(), self.result1)


    @mock.patch.object(essearch.SearchElasticSearch, 'search_elasticsearch')
    def test_get_event_id(self, func):
        func.return_value = self.return_value1
        cres = self.rf.get('/logapi/event/community/view/1/')
        self.assertEqual(cres.json(), self.result1)

    @mock.patch.object(essearch.SearchElasticSearch,'search_elasticsearch')
    def test_get_user_id_event(self, func):
        func.return_value = self.return_value1
        cres = self.rf.get('/logapi/user/1/event/community/view/')
        self.assertEqual(cres.json(), self.result1)
    
    @mock.patch.object(essearch.SearchElasticSearch, 'search_elasticsearch')
    def test_get_user_id_event_id(self, func):
        func.return_value = self.return_value1
        cres = self.rf.get('/logapi/user/1/event/community/view/1/')
        self.assertEqual(cres.json(), self.result1)

    @mock.patch.object(essearch.SearchElasticSearch, 'search_elasticsearch')
    def test_nothing_found_response(self, func):
        func.return_value = self.return_value2
        cres = self.rf.get('/logapi/user/2/')
        self.assertEqual(cres.json(), self.result2)

    @mock.patch.object(essearch.SearchElasticSearch, 'search_elasticsearch')
    def test_error_response(self, func):
        func.return_value = self.return_value3
        cres = self.rf.get('/logapi/user/2/')
        self.assertEqual(cres.json(), self.result3)





