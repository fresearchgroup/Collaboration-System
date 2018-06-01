import time.time
import datetime.datetime
import json
import logprocess
import settings

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
        with open(self.conf['filename'], 'w') as fp:
            json.dump(logVal, fp)
            

def create_log(event_name, data):
    dic = {}
    
    # APPENDING COMMON FIELDS
    for key in list(settings.COMMON_FIELDS.keys()):
        f = settings.COMMON_FIELDS[key]
        dic[key] = f(data)

    event_specific = {}
    for key in list(settings.CONTEXT_SPECIFIC_FIELDS.keys()):
        f = settings.CONTEXT_SPECIFIC_FIELDS[key]
        event_specific[key] = f()

    div["event"] = event_specific
    
    return dic
