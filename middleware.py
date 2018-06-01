from .main.eventtracker import EventTracker
from .parsecustom import ParseCustom

class Middleware:
    
    def __init__(self, get_response):
        self.get_response = get_response
        self.eventlogger = EventTracker()
        self.cparser = ParseCustom()
        self.eventlogger.run()

    def __call__(self, request):
        return self.get_response(request)
    
    def process_view(self, request, view_func, view_args, view_kwargs):
        data = {}
        data['request'] = request
        data['view_func'] = view_func
        data['view_args'] = view_args
        data['view_kwargs'] = view_kwargs
        print('*************************')
        print(data['request'].META['PATH_INFO'])
        print(data['request'].method)
        print('*************************')
        self.eventlogger.sendRequestData(data)
        return None

