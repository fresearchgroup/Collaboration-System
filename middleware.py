from .main.eventtracker import EventTracker
from . import utils

class Middleware:
    
    def __init__(self, get_response):
        self.LOG_CLASS = "MIDDLEWARE"
        self.get_response = get_response
        self.eventlogger = EventTracker()
        self.eventlogger.run()

    def __call__(self, request):
        return self.get_response(request)
    
    def process_view(self, request, view_func, view_args, view_kwargs):
        data = {}
        data['request'] = request
        data['view_func'] = view_func
        data['view_args'] = view_args
        data['view_kwargs'] = view_kwargs
        utils.ilog(self.LOG_CLASS, data['request'].META['PATH_INFO'])
        utils.ilog(self.LOG_CLASS, data['request'].method)
        utils.ilog(self.LOG_CLASS, data['request'].POST)
        utils.ilog(self.LOG_CLASS, data['request'].GET)
        self.eventlogger.sendRequestData(data)
        return None

