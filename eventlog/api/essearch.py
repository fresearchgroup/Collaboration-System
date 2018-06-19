'''
  This module is used to build the query structure that can 
  be used to query elastic search using elasticsearch api and 
  to capture the response and return it to search_elasticsearch
  caller
'''

from elasticsearch import Elasticsearch
from . import settings

class SearchElasticSearch:
    
    def __init__(self):
        self.LOG_CLASS = "SearchElasticSearch"
        self.index = settings.ES_INDEX
        self.es = Elasticsearch(settings.SERVER_CONF)
        self.outter_keys = settings.OUTTER_KEYS
      
    def build_search_body(self,search_key_dic):
        
        body = {
            "from" : 0,
            "size" : 0,
            "_source": {
                  "includes": []
            }, 
            "sort" : [],
            "aggs" : {},
            "query" : {
               "bool" : {
                   "must":[
                    {
                       "range" : {
                           "time-stamp.keyword":{
                            }
                        }
                    },
                   ],
                    "filter" : [
                   ]
                },
            }
         }

        must_keys = search_key_dic['request_keys'].keys()

        for key in must_keys:
            match={"match":{}}
            if key in self.outter_keys:
                match["match"].update({key:search_key_dic['request_keys'][key]})
            else:
                match["match"].update({'event.'+key:search_key_dic['request_keys'][key]})
            body["query"]["bool"]["must"].append(match)

        if "paging" in search_key_dic.keys():
            body["from"] = search_key_dic["paging"]["from"]
            body["size"] = search_key_dic["paging"]["size"]
           
        if "fields" in search_key_dic.keys():
              field_list =search_key_dic["fields"]
              for field in field_list:
                   body["_source"]["includes"].append(field)
        
        if "sorts" in search_key_dic.keys():
            for item in search_key_dic["sorts"]:
                 for key in item:
                    if key in self.outter_keys:
                         body["sort"].append({key+'.keyword':{"order":item[key]}})
                    else:
                         body["sort"].append({'event.'+key+'.keyword':{"order":item[key]}})

        if "filters" in search_key_dic.keys():
            items = search_key_dic["filters"]
            for item in items:
                key = list(item.keys())[0]
                if key in self.outter_keys:
                     body["query"]["bool"]["filter"].append({"term":item})
                else:
                     body["query"]["bool"]["filter"].append({"term":{'event.'+key:item[key]}})
        
        if "agg_keys" in search_key_dic.keys():
            items = search_key_dic["agg_keys"]
            for item in items:
                key = list(item.keys())[0]
                main_dic={}
                for key in self.outter_keys:
                    dic = {"field":item+'.keyword'}
                    main_dic.update({item[key]:dic})
                body["args"].update({item+'_agg':main_dic})
            else:
                key = list(item.keys())[0]
                main_dic={}
                for key in self.outter_keys:
                    dic = {"field":'event.'+item+'.keyword'}
                    main_dic.update({item[key]:dic})
                body["args"].update({item+'_agg':main_dic})

        if "time_range" in search_key_dic.keys():        
            body["query"]["bool"]["must"][0]["range"]["time-stamp.keyword"].update({"gte":search_key_dic['time_range']['after']})
            body["query"]["bool"]["must"][0]["range"]["time-stamp.keyword"].update({"lte":search_key_dic['time_range']['before']})

        return body    
                
    
    def search_elasticsearch(self,search_key_dic):
            response = {}  
            try:
                body = self.build_search_body(search_key_dic)     
                res =  self.es.search(index=self.index,body=body)
                total_hits = res['hits']['total']
                response = {}
                status = 200
                logs = []
                for hit in res['hits']['hits']:
                        logs.append(hit['_source'])
                response.update({'status':status})
                response.update({'total_hits': total_hits})
                response.update({'logs':logs})
            except Exception as e:
                response.update({'error': e.args})
            return response
