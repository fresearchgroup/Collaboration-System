import time
import datetime
import json
from . import logprocess
from . import settings

class StoreLog:

    def __init__(self, method = 'store', conf = {}):
        self.method = method
        self.conf = conf
        if self.method == "store":
            if "filename" not in list(self.conf.keys()):
                self.conf['filename'] = 'debug.log' 

    def run(self, logVal):
        if self.method == "store":
            self._store_file(logVal)


    def _store_file(self, logVal):
        print('*********************************************')
        print(logVal)
        with open(self.conf['filename'], 'w') as fp:
            json.dump(logVal, fp)
            

def create_log(event_name, data):
    dic = {}
    print('#######################################')
    print(event_name)
    # APPENDING COMMON FIELDS
    for key in list(settings.COMMON_FIELDS.keys()):
        f = settings.COMMON_FIELDS[key]
        dic[key] = f(data)
 
    event_specific = {}
    for key in list(settings.CONTEXT_SPECIFIC_FIELDS[event_name].keys()):
        f = settings.CONTEXT_SPECIFIC_FIELDS[event_name][key]
        print(f.__name__)
        event_specific[key] = f(data)

    div["event"] = event_specific
    
    return dic
