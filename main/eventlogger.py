import time
import datetime
import json
import urllib3
from . import logprocess
from . import settings

STORE = 1
TOSERVER = 2
class StoreLog:

    def __init__(self, method = 'store', conf = {}):
        self.method = method
        self.conf = conf
        if self.method == STORE:
            if "filename" not in list(self.conf.keys()):
                self.conf['filename'] = 'debug.log'
        elif self.method == TOSERVER:
            if 'address' not in list(self.conf.keys()):
                self.conf['address'] = '127.0.0.1'
            if 'port' not in list(self.conf.keys()):
                self.conf['port'] = 8080

    def run(self, logVal):
        if self.method == STORE:
            self._store_file(logVal)
        elif self.moethod == TOSERVER:
            self._to_server(logVal)

    def _to_server(self, logVal):
        pass

    def _store_file(self, logVal):
        with open(self.conf['filename'], 'a') as fp:
             fp.write(json.dumps(logVal))
            

def create_log(event_name, data):
    dic = {}
    
    # APPENDING COMMON FIELDS
    for key in list(settings.COMMON_FIELDS.keys()):
        f = settings.COMMON_FIELDS[key]
        dic[key] = f(data)

    event_specific = {}
    for key in list(settings.CONTEXT_SPECIFIC_FIELDS[event_name].keys()):
        f = settings.CONTEXT_SPECIFIC_FIELDS[event_name][key]
        print(f.__name__)
        event_specific[key] = f(data)

    dic["event"] = event_specific
    print(dic)
    
    return dic
