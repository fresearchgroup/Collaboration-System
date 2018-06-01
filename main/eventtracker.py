import threading
from . import eventlogger
from . import eventNameMapping

class EventTracker(object):

    def __init__(self):
        #self.lock = threading.Lock()
        self.bucket = []
        self.logstore = eventlogger.StoreLog()

    def sendRequestData(self, data):
        self.bucket.append(data)
        print("[EventTraccker.sendRequestData INFO] new data object added to bucket")
        print("[EventTracker.processRequest INFO]: SIZE OF BUCKET: {!s}".format(len(self.bucket)))

    def processRequest(self):
        while True:
            if len(self.bucket) > 0:
                print("[EventTracker.processRequest INFO]: SIZE OF BUCKET: {!s}".format(len(self.bucket)))
                data = self.bucket[0]
                self.bucket.pop(0)
                print("[EventTracker.processRequest INFO]: {!s}".format(data))

                #TODO:
                #add function for getting the name of the event
                #add function for creating the logs for event
                #add function for adding the log to file or pass through http as needed
                event_name = eventNameMapping.get_eventName_from_request(data['request'])
                if event_name != None:
                    eventlogger.create_log(event_name, data)
                    self.logstore.run(logval)
            #break
            #else:
               #print("[EventTracker.processRequest INFO]: Empty bucket")

    def run(self):
        print('[EventTracker.run INFO]: Event tracker module is up')
        processingThread = threading.Thread(target = self.processRequest)
        processingThread.setDaemon(True)
        processingThread.start()
        #processingThread.join()

