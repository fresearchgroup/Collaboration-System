from .main.eventtracker import EventTracker
from .parsecustom import ParseCustom

class Middleware:
    
    def __init__(self, get_response):
        self.get_response = get_response
        #self.eventlogger = EventTracker()
        self.cparser = ParseCustom()
        #self.eventlogger.run()

    def __call__(self, request):
        #print("middleware inside -----------------------__call__")
        return self.get_response(request)
    
    def process_view(self, request, view_func, view_args, view_kwargs):
        #print("--------------------------middleware-----------------------------")
        data = {}
        #data['request'] = request
        #data['view_func'] = view_func
        #data['view_args'] = view_args
        #data['view_kwargs'] = view_kwargs
        print('parsing data pretty format')
        print(request.GET)
        print(request.POST)
        #self.cparser.parseDictRec(data)
        print(request.user)
        print(view_args)
        print(view_kwargs)
        #print(dir(request))
        print("[PATH INFO]:  " + request.path_info)
        #self.eventlogger.sendRequestData(data)
        return None

