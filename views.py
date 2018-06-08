from django.shortcuts import render
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.views import APIView
import requests
from .essearch import SearchElasticSearch
import json
# Create your views here.

def id_match(name):
    return name+"-id"
    pass

@api_view(['GET', 'POST'])
def get_user_id(request, id):
    data = {'user-id': id}
    obj=SearchElasticSearch()
    result = obj.search_elasticsearch(data)
    length=len(result)

    if(length>0):
        res= {"Status Code": 200, "total hits": length, "result": result }
        return Response(res)
    else:
        return Response({"Status Code": 200, "total hits": 0, "result": "No Data Found"})

@api_view(['GET', 'POST'])
def get_event(request, param1, param2):
    data = {'event_name': ".".join(["event", param1, param2])}
    obj=SearchElasticSearch()
    result = obj.search_elasticsearch(data)
    length=len(result)
    if(length>0):
        return Response({"Status Code": 200, "total hits": length, "result": result })
    else:
        return Response({"Status Code": 200, "total hits": 0, "result": "No Data Found"})

def get_event_id(request, param1, param2, eid):
    id_name=id_match(param1)
    data = {
                'event_name': ".".join(["event", param1, param2]), 
                id_name: eid
            }
    obj=SearchElasticSearch()
    result = obj.search_elasticsearch(data)
    length=len(result)

    if(length>0):
        return Response({"Status Code": 200, "total hits": length, "result": result })
    else:
        return Response({"Status Code": 200, "total hits": 0, "result": "No Data Found"})

@api_view(['GET', 'POST'])
def get_user_id_event(request, id, param1, param2):
    data = {
                'user-id': id,
                "event_name": ".".join(["event", param1, param2])
            }
    obj=SearchElasticSearch()
    result = obj.search_elasticsearch(data)
    length=len(result)
    if(length>0):
        return Response({"Status Code": 200, "total hits": length, "result": result })
    else:
        return Response({"Status Code": 200, "total hits": 0, "result": "No Data Found"})

@api_view(['GET', 'POST'])
def get_user_id_event_id(request, id, param1, param2, eid):
    id_name=id_match(param1)
    data = {
            'user-id': id,
            "event_name": ".".join(["event", param1, param2]),
            id_name: eid
            }
    obj=SearchElasticSearch()
    result = obj.search_elasticsearch(data)
    length=len(result)
    if(length>0):
        return Response({"Status Code": 200, "total hits": length, "result": result })
    else:
        return Response({"Status Code": 200, "total hits": 0, "result": "No Data Found"})
