import time
import datetime
import json
import urllib3
from . import logprocess
from . import settings

class StoreLog:

    def __init__(self):
        self.LOG_CLASS = "StoreLog"
        self.method = settings.LOG_TYPE
        if self.method == settings.STORE:
             self.conf = settings.STORE_CONF
        elif self.method == settings.TOSERVER:
            self.conf = settings.SERVER_CONF
            
    def run(self, logVal):
        if self.method == settings.STORE:
            self._store_file(logVal)
        elif self.method == settings.TOSERVER:
            self._to_server(logVal)

     def _to_server(self, logVal):
        if self.conf['protocol'] != None:
            c_url = self.conf['protocol'] + "://" + self.conf['address'] + ":" + str(self.conf['port'])
        else:
            c_url = self.conf['address'] + ":" + str(self.conf['port'])
        print("[" + self.LOG_CLASS + " INFO]: Sending json to: " + c_url)
        headers = {"User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36"}
        if 'proxies' in list(self.conf.keys()):
            if "proxy_auth" in list(self.conf.keys()):
                cauth = HTTPProxyAuth(self.conf['proxy_auth']['username'], self.conf['proxy_auth']['password'])
                r = requests.put(c_url, json=logVal, proxies=self.conf['proxies'], auth = cauth, headers = headers)
            else:
                r = requests.put(c_url, json=logVal, proxies=self.conf['proxies'], headers = headers)
        else:
            r = request.put(c_url, json=logVal, headers = headers)
        print("[" + self.LOG_CLASS + " INFO]: Status Code: " + str(r.status_code))

    def _store_file(self, logVal):
        try:
            with open(self.conf['filename'], 'a') as fp:
                fp.flush()
                fp.write(json.dumps(logVal))
                fp.flush()
        except IOError as io:
            print(io)

            
def create_log(event_name, data):
    dic = {}
    
    # APPENDING COMMON FIELDS
    for key in list(settings.COMMON_FIELDS.keys()):
        f = settings.COMMON_FIELDS[key]
        dic[key] = f(data)

    event_specific = {}
    for key in list(settings.CONTEXT_SPECIFIC_FIELDS[event_name].keys()):
        f = settings.CONTEXT_SPECIFIC_FIELDS[event_name][key]
        #print(f.__name__)
        event_specific[key] = f(data)
    dic['event_name'] =event_name
    dic["event"] = event_specific   

    print('####################')
    print(event_name) 
    return dic
