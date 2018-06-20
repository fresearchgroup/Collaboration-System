from ..api import helpers
from ..api import essearch
from django.test import RequestFactory
from django.test import TestCase
from unittest import mock
import elasticsearch

class TestHelperClass(TestCase):

    def setUp(self):
        self.elastic_search_result = {
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

    @mock.patch.object(essearch.SearchElasticSearch, 'search_elasticsearch')
    @mock.patch.object(helpers, 'make_request_body')
    def test_handle_response(self, esfunc):
        func.return_value = self.elastic_search_result
        helpers.handle_response(request, )
        
