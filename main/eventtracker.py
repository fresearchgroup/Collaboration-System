import threading
from . import eventlogger
from . import eventNameMapping

class EventTracker(object):

    def __init__(self):
        self.bucket = []
        self.logstore = eventlogger.StoreLog()

    def sendRequestData(self, data):
        self.bucket.append(data)
        print("[EventTracker.sendRequestData INFO] new data object added to bucket")
        print("[EventTracker.sendRequestData INFO]: SIZE OF BUCKET: {!s}".format(len(self.bucket)))

    def processRequest(self):
        while True:
            if len(self.bucket) > 0:
                print("[EventTracker.processRequest INFO]: SIZE OF BUCKET: {!s}".format(len(self.bucket)))
                data = self.bucket[0]
                self.bucket.pop(0)
                print("[EventTracker.processRequest INFO]: {!s}".format(data))

                event_name = eventNameMapping.get_eventName_from_request(data['request'])
                if event_name != None:
                    logVal = eventlogger.create_log(event_name, data)
                    print("[EventTracker INFO]: log sent for storage")
                    self.logstore.run(logVal)

    def run(self):
        print('[EventTracker.run INFO]: Event tracker module is up')
        processingThread = threading.Thread(target = self.processRequest)
        processingThread.setDaemon(True)
        processingThread.start()
