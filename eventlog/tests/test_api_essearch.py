from ..api import essearch
from django.test import RequestFactory
from django.test import TestCase
from unittest import mock
import elasticsearch


class TestEssearch(TestCase):

    def setUp(self):
        self.es = essearch.SearchElasticSearch()
        self.maxDiff = None
        self.fields = {
                'server-host': '12826df87baa',
                'ip-address': '172.18.0.1',
                'session-id': 'hl8950uyfhqi7y8yfcf86sq9wqjukjli',
                'path-info': '/community-view/1/',
                'accept-language': 'en-US,en;q=0.9',
                'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.62 Safari/537.36',
                'referer': 'http://localhost:8000/',
                'event-source':'server',
                'time-stamp': '2018-06-15 18:23:40',
                'event_name': 'event.community.view',
                'host': '1',
                '@version': '1',
                'headers': 'None',
                '@timestamp': '2018-06-15T18:42:43Z',
                'user-id': '1'
            }
        self.output = {'query': 
                            {'bool': 
                                {'must': 
                                    [
                                    {'match': {'server-host': '12826df87baa'}}, 
                                    {'match': {'ip-address': '172.18.0.1'}}, 
                                    {'match': {'session-id': 'hl8950uyfhqi7y8yfcf86sq9wqjukjli'}}, 
                                    {'match': {'path-info': '/community-view/1/'}}, 
                                    {'match': {'accept-language': 'en-US,en;q=0.9'}}, 
                                    {'match': {'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.62 Safari/537.36'}}, 
                                    {'match': {'referer': 'http://localhost:8000/'}}, 
                                    {'match': {'event-source': 'server'}}, 
                                    {'match': {'time-stamp': '2018-06-15 18:23:40'}}, 
                                    {'match': {'event_name': 'event.community.view'}}, 
                                    {'match': {'host': '1'}}, 
                                    {'match': {'@version': '1'}}, 
                                    {'match': {'headers': 'None'}}, 
                                    {'match': {'@timestamp': '2018-06-15T18:42:43Z'}}, 
                                    {'match': {'user-id': '1'}}
                                    ]
                                }
                            }
                        }
        self.result_essearch = {
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
    
    def teardown(self):
        pass

    def test_build_search_body(self):
        self.assertEqual(self.es.build_search_body(self.fields), self.output)
    
    @mock.patch('elasticsearch.Elasticsearch.search')
    def test_search_elasticsearch(self, esfunc):
        esfunc.return_value = {
        "took": 16,
        "timed_out": 'false',
        "_shards": {
            "total": 5,
            "successful": 5,
            "skipped": 0,
            "failed": 0
        },
        "hits": {
            "total": 1,
            "max_score": 0.18232156,
            "hits": [
                {
                "_index": "logs",
                "_type": "doc",
                "_id": "Ix6QA2QBKird6lIx3aIx",
                "_score": 0.18232156,
                "_source": {
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
                    }
                },
            ]
            }
        }
        temp = self.es.search_elasticsearch({'user-id': 1})
        self.assertEqual(temp, self.result_essearch)



