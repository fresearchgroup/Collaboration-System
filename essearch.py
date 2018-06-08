from elasticsearch import Elasticsearch
from . import settings

class SearchElasticSearch:
    
    def __init__(self):
        self.index = settings.ES_INDEX
        self.es = Elasticsearch()
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
            body = self.build_search_body(search_key_dic)
            res =  self.es.search(index=self.index,body=body)
            response = []
            for hit in res['hits']['hits']:
                response.append(hit['_source'])
            return response