import threading
from . import eventlogger
from . import eventNameMapping
from .. import utils

class EventTracker(object):

    def __init__(self):
        self.LOG_CLASS = "EventTracker"
        self.bucket = []
        self.logstore = eventlogger.StoreLog()

    def sendRequestData(self, data):
        self.bucket.append(data)
        utils.ilog(self.LOG_CLASS, "new data object added to bucket")
        utils.ilog(self.LOG_CLASS, "SIZE OF BUCKET: {!s}".format(len(self.bucket)))

    def processRequest(self):
        while True:
            if self.bucket:
                utils.ilog(self.LOG_CLASS, "SIZE OF BUCKET: {!s}".format(len(self.bucket)))
                data = self.bucket[0]
                self.bucket.pop(0)
                utils.ilog(self.LOG_CLASS, "{!s}".format(data))

                event_name = eventNameMapping.get_eventName_from_request(data['request'])
                utils.ilog(self.LOG_CLASS, event_name)
                if event_name != None:
                    logVal = eventlogger.create_log(event_name, data)
                    utils.ilog(self.LOG_CLASS, "log sent for storage")
                    self.logstore.run(logVal)

    def run(self):
        utils.ilog(self.LOG_CLASS, 'Event tracker module is up', imp = True)
        processingThread = threading.Thread(target = self.processRequest, name="process request thread")
        processingThread.setDaemon(True)
        processingThread.start()
