from django.shortcuts import render
from rest_framework.decorators import api_view, schema
from rest_framework.response import Response
from rest_framework.views import APIView
import requests
# Create your views here.

@api_view(['GET', 'POST'])
@schema(None)
def get_user_id(request, id):
    data = {'id': id}
    return Response('{"method": "get_user_id", "data": ' + str(data) + "}")

@api_view(['GET', 'POST'])
@schema(None)
def get_event(request, param1, param2):
    data = {'event_name': ".".join(["event", param1, param2])}
    return Response('{"method": "get_event", "data": ' + str(data) + "}")

@api_view(['GET', 'POST'])
@schema(None)
def get_event_id(request, param1, param2, eid):
    data = {'event_name': ".".join(["event", param1, param2]), "eid": eid}
    return Response('{"method": "get_event_id"}, "data": ' + str(data) + "}")

@api_view(['GET', 'POST'])
@schema(None)
def get_user_id_event(request, id, param1, param2):
    data = {'user_id': id, "event_name": ".".join(["event", param1, param2])}
    return Response('{"method": "get_user_id_event"}, "data": ' + str(data) + "}")

@api_view(['GET', 'POST'])
@schema(None)
def get_user_id_event_id(request, id, param1, param2, eid):
    data = {
            'user_id': id,
            "event_name": ".".join(["event", param1, param2]),
            "eid": eid
            }
    return Response('{"method": "get_user_id_event_id"}, "data": ' + str(data) + "}")
