from ..api import essearch
from django.test import RequestFactory
from django.test import TestCase
from unittest import mock
import elasticsearch
from .. import utils

class TestEssearch(TestCase):

    def setUp(self):
        self.LOG_CLASS = "TestEssearch"
        self.es = essearch.SearchElasticSearch()
        self.maxDiff = None

        #TESTCASE 1
        self.input_dic = {
                'request_keys': {
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
                     'user-id': '1',
                },
                'paging' : {
                    'from' : 0,
                    'size' : 10
                },
                'fields' : [
                     'ip-address'
                ],
                'time_range' : {
                   'after' : '2018-06-01 00:00:00',
                   'before' : '2018-06-20 00:00:00'
                },
                'filter_keys' : [
                    {
                         'user-id' : 1
                    }
                ],
                'sort_keys' : [
                    {
                       'user-id' : 'asc'
                    }
                ]
        }
        self.output = {   "from" : 0,
                          "size" : 10,
                          "_source": {
                                "includes": ['ip-address']
                          }, 
                          'sort':[
                             {
                                'user-id.keyword':{
                                   'order': 'asc'
                                }
                             }
                          ],
                          'query': 
                            {'bool': 
                                {
                                'must': 
                                    [
                                    {
                                       "range" : {
                                          "time-stamp.keyword":{
                                               'gte' : '2018-06-01 00:00:00',
                                               'lte' : '2018-06-20 00:00:00'
                                           }
                                        }
                                    },
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
                                    ],
                                    'filter':[
                                       {'term': { 'user-id' : 1}}
                                    ]
                                }
                            }
        }
        
        #TestCase 2
        self.input_agg1 = {
                'request_keys':{
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
                     'user-id': '1',
                },
                'paging' : {
                    'from' : 0,
                    'size' : 10
                },
                'time_range' : {
                   'after' : '2018-06-01 00:00:00',
                   'before' : '2018-06-20 00:00:00'
                },
                'filter_keys' : [
                    {
                         'user-id' : 1
                    }
                ],
                'agg_keys':[
                   {
                     'article-id' : 'value_count'
                   }
                ]
        }
        self.output_agg1 = {
        "size": 0,
        "aggs": {
           "article-id_agg": {
                 "value_count": {
                    "field": "event.article-id.keyword"
                  }
            }
        },
        "query": {
            "bool": {
                "must": [
                    {
                        "range": {
                            "time-stamp.keyword": {
                                "gte": "2018-06-01 00:00:00",
                                "lte": "2018-06-20 00:00:00"
                            }
                        }
                    }
                ],
                "filter": [
                    {
                            "term": {
                                "user-id": 1
                            }
                        }
                    ]
                }
            }
        }
        #TESTCASE 3
        self.input_agg2 = {
                'request_keys':{
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
                     'user-id': '1',
                },
                'paging' : {
                    'from' : 0,
                    'size' : 10
                },
                'time_range' : {
                   'after' : '2018-06-01 00:00:00',
                   'before' : '2018-06-20 00:00:00'
                },
                'filter_keys' : [
                    {
                         'user-id' : 1
                    }
                ],
                'agg_keys':[
                   {
                     'article-id' : 'terms'
                   }
                ]
        }
        self.output_agg2 ={
            "size": 0,
            "aggs": {
                "article-id_agg": {
                    "terms": {
                        "field": "event.article-id.keyword",
                        "size": 10
                    }
                }
            },
            "query": {
                 "bool": {
                        "must": [
                        {
                            "range": {
                                "time-stamp.keyword": {
                                    "gte": "2018-06-01 00:00:00",
                                    "lte": "2018-06-20 00:00:00"
                                }
                            }
                        }
                        ],
                        "filter": [{
                            "term": {
                            "user-id": 1
                            }
                        }]
                 }
            }
        }
        #TESTCASE 4 
        self.input_agg3 = {
                'request_keys':{
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
                     'user-id': '1',
                },
                'paging' : {
                    'from' : 0,
                    'size' : 10
                },
                'time_range' : {
                   'after' : '2018-06-01 00:00:00',
                   'before' : '2018-06-20 00:00:00'
                },
                'filter_keys' : [
                    {
                         'user-id' : 1
                    }
                ],
                'agg_keys':[
                   {
                     'user-id' : 'terms'
                   }
                ]
        }
        self.output_agg3 = {
            "size": 0,
            "aggs": {
                "user-id_agg": {
                    "terms": {
                        "field": "user-id.keyword",
                        "size": 10
                    }
                }
            },
            "query": {
                 "bool": {
                        "must": [
                        {
                            "range": {
                                "time-stamp.keyword": {
                                    "gte": "2018-06-01 00:00:00",
                                    "lte": "2018-06-20 00:00:00"
                                }
                            }
                        }
                        ],
                        "filter": [{
                            "term": {
                            "user-id": 1
                            }
                        }]
                 }
            }
        }
        #TESTCASE 5 
        self.input_agg4 = {
                'request_keys':{
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
                     'user-id': '1',
                },
                'paging' : {
                    'from' : 0,
                    'size' : 10
                },
                'time_range' : {
                   'after' : '2018-06-01 00:00:00',
                   'before' : '2018-06-20 00:00:00'
                },
                'filter_keys' : [
                    {
                         'user-id' : 1
                    }
                ],
                'agg_keys':[
                   {
                     'user-id' : 'cardinality'
                   }
                ]
        }
        self.output_agg4 = {
            "size": 0,
            "aggs": {
                "user-id_agg": {
                    "cardinality": {
                        "field": "user-id.keyword"
                    }
                }
            },
            "query": {
                 "bool": {
                        "must": [
                        {
                            "range": {
                                "time-stamp.keyword": {
                                    "gte": "2018-06-01 00:00:00",
                                    "lte": "2018-06-20 00:00:00"
                                }
                            }
                        }
                        ],
                        "filter": [{
                            "term": {
                            "user-id": 1
                            }
                        }]
                 }
            }
        }
        #TESTCASE 6
        self.input_dic2 = {
                'request_keys': {
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
                     'user-id': '1',
                },
                'paging' : {
                    'from' : 0,
                    'size' : 10
                },
                'fields' : [
                     'ip-address'
                ],
                'time_range' : {
                   'after' : '2018-06-01 00:00:00',
                   'before' : '2018-06-20 00:00:00'
                },
                'filter_keys' : [
                ],
                'sort_keys' : [
                    {
                        'time-stamp' : 'desc'
                    }
                ]
        }
        self.output_dic2 = {   "from" : 0,
                          "size" : 10,
                          "_source": {
                                "includes": ['ip-address']
                          }, 
                          'sort':[
                              {
                                'time-stamp.keyword':{
                                   'order': 'desc'
                                }
                             }
                          ],
                          'query': 
                            {'bool': 
                                {
                                'must': 
                                    [
                                    {
                                       "range" : {
                                          "time-stamp.keyword":{
                                               'gte' : '2018-06-01 00:00:00',
                                               'lte' : '2018-06-20 00:00:00'
                                           }
                                        }
                                    },
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
                                    ],
                                    'filter':[
                                    ]
                                }
                            }
        }
        #TESTCASE 7
        self.input_dic3={
                'request_keys': {
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
                     'user-id': '1',
                },
                'paging' : {
                    'from' : 0,
                    'size' : 10
                },
                'fields' : [
                     'ip-address'
                ],
                'time_range' : {
                   'after' : '2018-06-01 00:00:00',
                   'before' : '2018-06-20 00:00:00'
                },
                'filter_keys' : [
                    {
                         'article-id' : 1
                    }
                ],
                'sort_keys' : [
                    {
                       'article-id' : 'asc'
                    }
                ]
        }
        self.output_dic3 = {   "from" : 0,
                          "size" : 10,
                          "_source": {
                                "includes": ['ip-address']
                          }, 
                          'sort':[
                             {
                                'event.article-id.keyword':{
                                   'order': 'asc'
                                }
                             }
                          ],
                          'query': 
                            {'bool': 
                                {
                                'must': 
                                    [
                                    {
                                       "range" : {
                                          "time-stamp.keyword":{
                                               'gte' : '2018-06-01 00:00:00',
                                               'lte' : '2018-06-20 00:00:00'
                                           }
                                        }
                                    },
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
                                    ],
                                    'filter':[
                                       {'term': { 'event.article-id' : 1}}
                                    ]
                                }
                            }
        }



        #elastic search
        self.result_essearch = {
                "status": 200,
                "total_hits":1,
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

        #elastic search 2
        self.result_essearch2 = {
                "status":200,
                "total_hits": 2,
                "logs":[
                     {
                         "key": 1,
                         "doc_count":2
                     },
                     {
                         "key":2,
                         "doc_count":1
                     }
                ]
        }
        self.result_essearch3 = {
                "status":200,
                "total_hits":1,
                "logs":[
                       {
                          "value":1
                       }
                    
                ]
        }
    
    def teardown(self):
        pass

    @mock.patch('elasticsearch.Elasticsearch.search')
    def test_elastic_search_func(self, esfuncf) :
        esfuncf.return_value = {
                "took": 16,
                "timed_out": 'false',
                "_shards": {
                "total": 2,
                "successful": 3,
                "skipped": 0,
                "failed": 0
            },
            "hits":{
               "total":3,
               "max_score":0,
               "hits":[]
            },
            "aggregations":{
                "user-id_aggs":{
                    "doc_count_error_upper_bound":0,
                    "sum_other_doc_count":0,
                    "buckets":[
                        {
                         "key": 1,
                         "doc_count":2
                        },
                        {
                         "key":2,
                         "doc_count":1
                        }
                    ]
                }
            }
        }  
        utils.ilog(self.LOG_CLASS, "RETURNED FROM func esfunc2 : {!s}".format(esfuncf.return_value))
        temp = self.es.search_elasticsearch({'request_keys':{'user-id': 1},'paging':{'from':0,'size':10}, 'agg_keys':[{'user-id' : 'terms'}]})
        self.assertEqual(temp, self.result_essearch2)

    @mock.patch('elasticsearch.Elasticsearch.search')
    def test_elastic_search_func3(self, esfuncd) :
        esfuncd.return_value = {
                "took": 16,
                "timed_out": 'false',
                "_shards": {
                "total": 2,
                "successful": 3,
                "skipped": 0,
                "failed": 0
            },
            "hits":{
               "total":3,
               "max_score":0,
               "hits":[]
            },
            "aggregations":{
                "user-id_aggs":{
                    "value":1
                }
            }
        }  
        utils.ilog(self.LOG_CLASS, "RETURNED FROM func esfunc3 : {!s}".format(esfuncd.return_value))
        temp = self.es.search_elasticsearch({'request_keys':{'user-id': 1},'paging':{'from':0,'size':10}, 'agg_keys':[{'user-id' : 'cardinality'}]})
        self.assertEqual(temp, self.result_essearch3)

    @mock.patch('elasticsearch.Elasticsearch.search')
    def test_build_search_body(self, esfunc):
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
        temp = self.es.search_elasticsearch({'request_keys':{'user-id': 1}})
        self.assertEqual(temp, self.result_essearch)
        self.assertEqual(self.es.build_search_body(self.input_dic), self.output)
        self.assertEqual(self.es.build_search_body(self.input_dic2), self.output_dic2)
        self.assertEqual(self.es.build_search_body(self.input_dic3), self.output_dic3)
        self.assertEqual(self.es.build_search_body_agg(self.input_agg1), self.output_agg1)
        self.assertEqual(self.es.build_search_body_agg(self.input_agg2), self.output_agg2)
        self.assertEqual(self.es.build_search_body_agg(self.input_agg3), self.output_agg3)
        self.assertEqual(self.es.build_search_body_agg(self.input_agg4), self.output_agg4)


    

