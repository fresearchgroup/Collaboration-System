'''
  This module is used to build the query structure that can 
  be used to query elastic search using elasticsearch api and 
  to capture the response and return it to search_elasticsearch
  caller
'''

from elasticsearch import Elasticsearch
from . import settings
from .. import utils

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
        utils.ilog(self.LOG_CLASS, "Entered request keys phase...", mode="DEBUG")
        for key in must_keys:
            match={"match":{}}
            if key in self.outter_keys:
                match["match"].update({key:search_key_dic['request_keys'][key]})
            else:
                match["match"].update({'event.'+key:search_key_dic['request_keys'][key]})
            body["query"]["bool"]["must"].append(match)

        utils.ilog(self.LOG_CLASS, "Entered paging keys phase...", mode="DEBUG")
        if "paging" in search_key_dic.keys():
            body["from"] = search_key_dic["paging"]["from"]
            body["size"] = search_key_dic["paging"]["size"]
           
        utils.ilog(self.LOG_CLASS, "Entered fields keys phase...", mode="DEBUG")
        if "fields" in search_key_dic.keys():
              field_list =search_key_dic["fields"]
              for field in field_list:
                   body["_source"]["includes"].append(field)
        
        utils.ilog(self.LOG_CLASS, "Entered sorts keys phase...", mode="DEBUG")
        if "sorts" in search_key_dic.keys():
            for item in search_key_dic["sorts"]:
                 for key in list(item.keys()):
                    if key in self.outter_keys:
                         body["sort"].append({str(key)+'.keyword':{"order":item[key]}})
                    else:
                         body["sort"].append({'event.'+str(key)+'.keyword':{"order":item[key]}})

        utils.ilog(self.LOG_CLASS, "Entered filters keys phase...", mode="DEBUG")
        if "filters" in search_key_dic.keys():
            items = search_key_dic["filters"]
            for item in items:
                key = list(item.keys())[0]
                if key in self.outter_keys:
                     body["query"]["bool"]["filter"].append({"term":item})
                else:
                     body["query"]["bool"]["filter"].append({"term":{'event.'+key:item[key]}})
        
        utils.ilog(self.LOG_CLASS, "Entered aggregation keys phase...", mode="DEBUG")
        if "agg_keys" in search_key_dic.keys():
            items = search_key_dic["agg_keys"]
            for item in items:
                utils.ilog(self.LOG_CLASS, "Inserting key: {!s}".format(item), mode="DEBUG")
                key = list(item.keys())[0]
                main_dic={}
                if key in self.outter_keys:
                    dic = {"field":str(key)+'.keyword'}
                    main_dic.update({item[key]:dic})
                else:
                    dic = {"field":'event.'+key+'.keyword'}
                    main_dic.update({item[key]:dic})
                body["aggs"].update({key+'_agg':main_dic})

        utils.ilog(self.LOG_CLASS, "Entered time range keys phase...", mode="DEBUG")
        if "time_range" in search_key_dic.keys():        
            body["query"]["bool"]["must"][0]["range"]["time-stamp.keyword"].update({"gte":search_key_dic['time_range']['after']})
            body["query"]["bool"]["must"][0]["range"]["time-stamp.keyword"].update({"lte":search_key_dic['time_range']['before']})
        
        utils.ilog(self.LOG_CLASS, "body format: {!s}".format(body), mode="DEBUG")

        return body    
                
    
    def search_elasticsearch(self,search_key_dic):
            response = {}  
            utils.ilog(self.LOG_CLASS, "Running search key", mode="DEBUG")
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
