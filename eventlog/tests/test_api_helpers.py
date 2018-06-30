from ..api import helpers
from ..api import essearch
from rest_framework.test import APIClient
from django.test import TestCase
from django.test import RequestFactory
from unittest import mock
import elasticsearch
import datetime
from ..api import settings
from ..api import exceptions
from django.http import HttpRequest
from .. import utils

class TestHelperClass(TestCase):

    def setUp(self):
        self.maxDiff = None
        self.rf = APIClient()
        self.elastic_search_result = {'status': 200, 'total_hits': 11, 'logs': [{'time-stamp': '2018-06-20 05:32:11', 'headers': {'http_accept': '*/*', 'content_type': 'application/json', 'http_accept_encoding': 'gzip, deflate', 'http_connection': 'keep-alive', 'http_version': 'HTTP/1.1', 'request_path': '/', 'request_method': 'PUT', 'http_host': 'logstash:5000', 'content_length': '516', 'request_uri': '/', 'http_user_agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36'}, 'referer': 'http://localhost:8000/login/?next=/community-view/1', 'accept-language': 'en-US,en;q=0.9', 'user-id': 2, 'path-info': '/community-view/1/', 'server-host': '826a4e98536d', 'ip-address': '172.18.0.1', '@timestamp': '2018-06-20T05:32:11.696Z', '@version': '1', 'host': '172.18.0.6', 'event_name': 'event.community.view', 'event': {'community-id': '1'}, 'event-source': 'server', 'user-agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.62 Safari/537.36', 'session-id': 'qbu9skvc6isvqx9ktopga8icm68ka3tq'}]}
        self.request_body =  {'request_keys': {'event_name': 'event.community.view'}, 'time_range': {'before': '2018-06-20 17:45:18', 'after': '2018-06-10 17:45:18'}, 'paging': {'from': 1, 'size': 1}, 'fields': ['server-host', 'ip-address', 'session-id', 'path-info', 'accept-language', 'user-agent', 'referer', 'host', 'event-source', 'time-stamp', 'event_name', '@version', 'headers', '@timestamp', 'user-id', 'event'], 'sorts': [{'time-stamp': 'desc'}]}
        self.result_handle_reponse = {
    "prev_link": "http://testserver/logapi/event/community/view/?start=0&limit=1",
    "next_link": "http://testserver/logapi/event/community/view/?start=2&limit=1",
    "status code": 200,
    "total hits": 11,
    "result": [
        {
            "time-stamp": "2018-06-20 05:32:11",
            "headers": {
                "http_accept": "*/*",
                "content_type": "application/json",
                "http_accept_encoding": "gzip, deflate",
                "http_connection": "keep-alive",
                "http_version": "HTTP/1.1",
                "request_path": "/",
                "request_method": "PUT",
                "http_host": "logstash:5000",
                "content_length": "516",
                "request_uri": "/",
                "http_user_agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36"
            },
            "referer": "http://localhost:8000/login/?next=/community-view/1",
            "accept-language": "en-US,en;q=0.9",
            "user-id": 2,
            "path-info": "/community-view/1/",
            "server-host": "826a4e98536d",
            "ip-address": "172.18.0.1",
            "@timestamp": "2018-06-20T05:32:11.696Z",
            "@version": "1",
            "host": "172.18.0.6",
            "event_name": "event.community.view",
            "event": {
                "community-id": "1"
            },
            "event-source": "server",
            "user-agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/67.0.3396.62 Safari/537.36",
            "session-id": "qbu9skvc6isvqx9ktopga8icm68ka3tq"
        }
    ]
}

    def teardown(self):
        pass
    

    @mock.patch.object(helpers, 'make_request_body')
    @mock.patch.object(essearch.SearchElasticSearch, 'search_elasticsearch')
    def test_handle_response(self, esfunc, mrbfunc):
        esfunc.return_value = self.elastic_search_result
        mrbfunc.return_value = self.request_body
        request = RequestFactory().get("/logapi/event/community/view/", {"start": 1, "limit": 1})
        data = {'event_name': "event.community.view"}
        res = helpers.handle_response(request, data)
        act_resp, status_code = res[0], res[1]
        #utils.ilog("HELPER CLASS", "print: {!s}".format(act_resp), mode="DEBUG")
        self.assertDictEqual(self.get_seperate(self.result_handle_reponse['prev_link']), self.get_seperate(act_resp['prev_link']))
        self.assertDictEqual(self.get_seperate(self.result_handle_reponse['next_link']), self.get_seperate(act_resp['next_link']))
        self.assertEqual(self.result_handle_reponse['status code'], act_resp['status code'])
        self.assertEqual(self.result_handle_reponse['total hits'], act_resp['total hits'])
        self.assertEqual(len(self.result_handle_reponse['result']), len(act_resp['result']))
        self.assertDictEqual(self.result_handle_reponse['result'][0], act_resp['result'][0])

    
    @mock.patch.object(helpers, 'custom_time_now')
    def test_extract_time_keys(self, tmfunc):
        current_date = '2018-06-20 10:20:40'
        tmfunc.return_value = datetime.datetime.strptime(current_date, "%Y-%m-%d %H:%M:%S")
        request = RequestFactory().get('/logapi/event/community/view', {'before':'2017-10-11T10:20:40'})
        act_result = helpers.extract_time_keys(request)
        exp_result = {
                "before": "2017-10-11 10:20:40",
                "after": "2017-10-01 10:20:40"
                }
        self.assertEqual(act_result, exp_result)
        request = RequestFactory().get("logapi/event/community/view/", {"after": "2018-06-01T10:20:40"})
        exp_result = {
                "before": current_date,
                "after": "2018-06-01 10:20:40"
                }
        act_result = helpers.extract_time_keys(request)
        self.assertEqual(act_result, exp_result)
        request = RequestFactory().get("logapi/event/community/view/")
        exp_result = {
                "before": current_date,
                "after": "2018-06-10 10:20:40" 
                }
        act_result = helpers.extract_time_keys(request)
        self.assertEqual(act_result, exp_result)
        request = RequestFactory().get("logapi/event/community/view/", {'before': "2018-6-1T10"})
        self.assertRaises(exceptions.BadTimeFormat, helpers.extract_time_keys, request)
        request = RequestFactory().get("logapi/event/community/view/", {'after': "2018-6-1T10"})
        self.assertRaises(exceptions.BadTimeFormat, helpers.extract_time_keys, request)


    def test_extract_field_keys(self):
        request = RequestFactory().get("/logapi/event/community/view/")
        exp_result = {
                "fields":['server-host', 'ip-address', 'session-id', 'path-info', 'accept-language', 'user-agent', 'referer', 'host', 'event-source', 'time-stamp', 'event_name', '@version', 'headers', '@timestamp', 'user-id', 'event']
                }
        act_result = helpers.extract_field_keys(request)
        #utils.ilog("TEST HELPER", "result actual: {!s}".format(act_result), mode="DEBUG")
        self.assertCountEqual(exp_result['fields'], act_result['fields'])
        request = RequestFactory().get("/logapi/event/community/view/", {"fields": ["event", "event_name", "host"]})
        exp_result = {
                "fields":['host', 'event_name','event']
                }
        act_result = helpers.extract_field_keys(request)
        self.assertCountEqual(exp_result['fields'], act_result['fields'])
    

    def test_extract_paging_keys(self):
        request = RequestFactory().get("/logapi/event/community/view/")
        exp_result = {
                    "from": 0,
                    "size": settings.PAGE_SIZE
                }
        act_result = helpers.extract_paging_keys(request)
        self.assertDictEqual(exp_result, act_result)
        request = RequestFactory().get("/logapi/event/community/view/", {"start": 1, "limit": 1})
        exp_result = {
                    "from": 1 ,
                    "size": 1
                }
        act_result = helpers.extract_paging_keys(request)
        self.assertDictEqual(exp_result, act_result)
        request = RequestFactory().get("/logapi/event/community/view/", {"start": 1})
        exp_result = {
                    "from": 1 ,
                    "size": settings.PAGE_SIZE
                }
        act_result = helpers.extract_paging_keys(request)
        self.assertDictEqual(exp_result, act_result)
        request = RequestFactory().get("/logapi/event/community/view/", {"limit": 1})
        exp_result = {
                    "from": 0,
                    "size": 1
                }
        act_result = helpers.extract_paging_keys(request)
        self.assertDictEqual(exp_result, act_result)
        request = RequestFactory().get("/logapi/event/community/view/", {"limit": 100000})
        exp_result = {
                    "from": 0,
                    "size": settings.MAX_PAGE_SIZE
                }
        act_result = helpers.extract_paging_keys(request)
        self.assertDictEqual(exp_result, act_result)

    def test_extract_filter_keys(self):
        request = RequestFactory().get("/logapi/event/community/view/")
        exp_result = {
                "filter_keys": []
                }
        act_result = helpers.extract_filter_keys(request)
        self.assertEqual(exp_result, act_result)
        request = RequestFactory().get("/logapi/event/community/view/", {'user-id': 1})
        exp_result = {
                "filter_keys": [{'user-id': '1'}]
                }
        act_result = helpers.extract_filter_keys(request)
        self.assertEqual(exp_result, act_result)
        request = RequestFactory().get("/logapi/event/community/view/", {'event_name': 'event.community.view'})
        exp_result = {
                "filter_keys": [{'event_name': 'event.community.view'}]
                }
        act_result = helpers.extract_filter_keys(request)
        self.assertEqual(exp_result, act_result)

    def test_extract_sort_keys(self):
        request = RequestFactory().get("/logapi/event/community/view/")
        exp_result = {
                "sort_keys": [
                    {'time-stamp': 'desc'}
                    ]
                }
        act_result = helpers.extract_sorting_keys(request)
        self.assertEqual(exp_result, act_result)
        request = RequestFactory().get("/logapi/event/community/view/", {"sort": ['time-stamp', '-event_name']})
        exp_result = {
                "sort_keys": [
                    {'time-stamp': 'asc'},
                    {'event_name': 'desc'}
                    ]
                }
        act_result = helpers.extract_sorting_keys(request)
        self.assertEqual(exp_result, act_result)

    def test_extract_agg_keys(self):
        request = RequestFactory().get("/logapi/event/community/view/")
        exp_result = {
                "agg_keys": []
                }
        act_result = helpers.extract_aggregate_key(request)
        self.assertEqual(exp_result, act_result)
        request = RequestFactory().get("/logapi/event/community/view/", {'agg_type': ['value_count'], "agg_field": ['event_name']})
        exp_result = {
                "agg_keys": [{'event_name': "value_count"}]
                }
        act_result = helpers.extract_aggregate_key(request)
        self.assertEqual(exp_result, act_result)
        request = RequestFactory().get("/logapi/event/community/view/", {'agg_type': ['value_count']})
        self.assertRaises(IndexError, helpers.extract_aggregate_key, request)
        request = RequestFactory().get("/logapi/event/community/view/", {'agg_type': ['value_count', 'cardinality'], "agg_field": ['event_name', 'user-id']})
        self.assertRaises(exceptions.MutlipleAggregationUnsupported, helpers.extract_aggregate_key, request)
  
    @mock.patch.object(helpers, 'extract_time_keys')
    def test_make_request_body(self, tmfunc):
        tmfunc.return_value = {'before': '2018-06-20 17:45:18', 'after':'2018-06-10 17:45:18'}
        request = RequestFactory().get('/logapi/event/community/view/')
        exp_result = {'request_keys': {'event_name': 'event.community.view'}, 'time_range': {'before': '2018-06-20 17:45:18', 'after': '2018-06-10 17:45:18'}, 'paging': {'from': 0, 'size': settings.PAGE_SIZE}, 'fields': ['server-host', 'ip-address', 'session-id', 'path-info', 'accept-language', 'user-agent', 'referer', 'host', 'event-source', 'time-stamp', 'event_name', '@version', 'headers', '@timestamp', 'user-id', 'event'], 'sort_keys': [{'time-stamp': 'desc'}]}
        exp_result['fields'].sort()
        act_result = helpers.make_request_body(request, {"event_name": "event.community.view"})
        act_result['fields'].sort()
        self.assertEqual(act_result, exp_result)
    
    def test_append_get_params(self):
        request = RequestFactory().get('/logapi/event/community/view', {'start': 0, "limit": 5})
        url = "http://localhost:8000/logapi/event/community/view/"
        exp_result = self.get_seperate("http://localhost:8000/logapi/event/community/view/?start=0&limit=5")
        act_result = self.get_seperate(helpers.append_get_params(url, request))
        self.assertDictEqual(exp_result, act_result)
    
    @mock.patch.object(HttpRequest, 'build_absolute_uri')
    def test_get_path(self, reqfunc):
        request = RequestFactory().get('/logapi/event/community/view', {'start': 0, "limit": 5})
        reqfunc.return_value = "http://localhost:8000/logapi/event/community/view/?start=0&limit=5"
        exp_result = "http://localhost:8000/logapi/event/community/view/"
        act_result = helpers.get_path(request)
        self.assertEqual(exp_result, act_result)
    
    @mock.patch.object(helpers, 'get_path')
    def test_append_pagination(self, gpfunc):
        resp = {}
        cpath = "http://localhost:8000/logapi/event/community/view/"
        gpfunc.return_value = cpath
        total_hits = 15
        #utils.ilog("TEST HELPER", "Calling for next link", mode="ERROR")
        request = RequestFactory().get('/logapi/event/community/view/', {'start': 0, "limit": 10})
        page_keys = {
                "from": 0,
                "size": 10
                }
        exp_result = {
                'next_link': self.get_seperate(cpath +"?start=10&limit=10")
                }
        resp = {}
        act_result = self.check_details(helpers.append_pagination(request, resp, page_keys, total_hits))
        #utils.ilog("Helper class", "act result: {!s}".format(act_result), mode="DEBUG")
        self.assertDictEqual(exp_result, act_result)
        #utils.ilog("TEST HELPER", "Calling for prev link", mode="ERROR")
        page_keys = {
                "from": 10,
                "size": 10
                }
        exp_result = {
                'prev_link': self.get_seperate(cpath + "?start=0&limit=10")
                }
        resp = {}
        act_result = self.check_details(helpers.append_pagination(request, resp, page_keys, total_hits))
        #utils.ilog("Helper class", "act result: {!s}".format(act_result), mode="DEBUG")
        self.assertDictEqual(exp_result, act_result)
        #utils.ilog("TEST HELPER", "Calling for both link", mode="ERROR")
        request = RequestFactory().get('/logapi/event/community/view/', {'start': 1, "limit": 1})
        page_keys = {
                "from": 1,
                "size": 1
                }
        exp_result = {
                "next_link": self.get_seperate(cpath + "?start=2&limit=1"),
                'prev_link': self.get_seperate(cpath + "?start=0&limit=1")
                }
        resp = {}
        act_result = self.check_details(helpers.append_pagination(request, resp, page_keys, total_hits))
        self.assertDictEqual(exp_result, act_result) 
        #utils.ilog("TEST HELPER", "Calling for no", mode="ERROR")
        request = RequestFactory().get('/logapi/event/community/view/', {'start': 0, "limit": 100})
        page_keys = {
                "from": 0,
                "size": 100
                }
        exp_result = {
                }
        resp = {}
        act_result = self.check_details(helpers.append_pagination(request, resp, page_keys, total_hits))
        self.assertDictEqual(exp_result, act_result)
        request = RequestFactory().get('/logapi/event/community/view/', {'start': 1, "limit": 4})
        page_keys = {
                "from": 1,
                "size": 4
                }
        exp_result = {
                "next_link": self.get_seperate(cpath + "?start=5&limit=4"),
                'prev_link': self.get_seperate(cpath + "?start=0&limit=1")
                }
        resp = {}
        act_result = self.check_details(helpers.append_pagination(request, resp, page_keys, total_hits))
        self.assertDictEqual(exp_result, act_result)

    def test_append_key_value(self):
        resp = {}
        exp_result = {
                "key": "value"
                }
        act_result = helpers.append_key_value(resp, "key", "value")
        self.assertEqual(exp_result, act_result)


    def test_append_error_key_value(self):
        resp= {}
        exp_result = {
                "error": {
                    "status code": 500
                    }
                }
        act_result = helpers.append_error_key_value(resp, "status code", 500)
        self.assertEqual(exp_result, act_result)
        resp= {
                "error": {
                    "status code": 500
                    }
                }
        exp_result = {
                "error": {
                    "status code": 500,
                    "error msg": "Database Error"
                    }
                }
        act_result = helpers.append_error_key_value(resp, "error msg", "Database Error")
        self.assertEqual(exp_result, act_result)

    def get_seperate(self, url):
        utils.ilog("TEST API HELPER", 'Got url: {!s}'.format(url))
        fields = {'main_url': '', 'start':'',"limit":""}
        m, p = url.split('?')
        p = p.split('&')
        fields['main_url'] = m
        for i in p:
            k = i.strip()
            if k.startswith('start'):
                fields['start'] = k
            elif k.startswith('limit'):
                fields['limit'] = k
            else:
                raise ValueError
        utils.ilog("TEST API HELPER", 'Generated for url: {!s}'.format(fields))
        return fields

    def check_details(self, dic):
        for key in list(dic.keys()):
            dic[key] = self.get_seperate(dic[key])
        return dic
        
