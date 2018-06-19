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
        
        search_keys = search_key_dic.keys()
        
        body = {
            "query" : {
               "bool" :{
                   "must":[]
                }
            }
        }

        for key in search_keys:
            match={"match":{}}
            if key in self.outter_keys:
                match["match"].update({key:search_key_dic[key]})
            else:
                match["match"].update({'event.'+key:search_key_dic[key]})
            body["query"]["bool"]["must"].append(match)

        return body    
                
    def search_elasticsearch(self,search_key_dic):
            response = {}          
            try:
                body = self.build_search_body(search_key_dic['request_keys'])
                res =  self.es.search(index=self.index,body=body)
                response = {}
                status = 200
                logs = []
                for hit in res['hits']['hits']:
                        logs.append(hit['_source'])
                response.update({'status':status})
                response.update({'logs':logs})
            except Exception as e:
                response.update({'error': e.args})
            return response
