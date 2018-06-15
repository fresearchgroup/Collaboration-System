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
    if 'status' in result.keys():
        res= {"Status Code": result['status'], "total hits": len(result['logs']), "result": result['logs'] }
        return Response(res)
    else:
        return Response({"error":result['error']})


@api_view(['GET', 'POST'])
def get_event(request, param1, param2):
    data = {'event_name': ".".join(["event", param1, param2])}
    obj=SearchElasticSearch()
    result = obj.search_elasticsearch(data)
    if 'status' in result.keys():
        res= {"Status Code": result['status'], "total hits": len(result['logs']), "result": result['logs'] }
        return Response(res)
    else:
        return Response({"error":result['error']})
    

@api_view(['GET', 'POST'])
def get_event_id(request, param1, param2, eid):
    id_name=id_match(param1)
    data = {
                'event_name': ".".join(["event", param1, param2]),
                id_name: eid
            }
    obj=SearchElasticSearch()
    result = obj.search_elasticsearch(data)
    if 'status' in result.keys():
        res= {"Status Code": result['status'], "total hits": len(result['logs']), "result": result['logs'] }
        return Response(res)
    else:
        return Response({"error":result['error']})


@api_view(['GET', 'POST'])
def get_user_id_event(request, id, param1, param2):
    data = {
                'user-id': id,
                "event_name": ".".join(["event", param1, param2])
            }
    obj=SearchElasticSearch()
    result = obj.search_elasticsearch(data)
    if 'status' in result.keys():
        res= {"Status Code": result['status'], "total hits": len(result['logs']), "result": result['logs'] }
        return Response(res)
    else:
        return Response({"error":result['error']})

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
    if 'status' in result.keys():
        res= {"Status Code": result['status'], "total hits": len(result['logs']), "result": result['logs'] }
        return Response(res)
    else:
        return Response({"error":result['error']})