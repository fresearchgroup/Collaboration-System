class ParseCustom:
    
    def __init__(self, cc = None):
        self.cc = cc
        pass

    def checkType(self, obj):
        if isinstance(obj, list):
            return self.parseListRec
        elif isinstance(obj, dict):
            return self.parseDictRec
        else:
            if self.cc != None:
                for cls in self.cc:
                    if isinstance(obj, cls):
                        return self.parseDir
            return None

    def printAsSuch(self, valueList, ind):
        for p in valueList:
            print("{!s}".format(p), end = ":")
        return None

    def parseListRec(self, obj, ind = 0):
        print("  " * ind + "[")
        for o in obj:
            toCall = self.checkType(o)
            if toCall == None:
                self.printAsSuch(["TYPE NOT PARSED", o, type(o)], ind)
            else:
                toCall(o, ind+1)
        print("  " * ind + "]")
        return None

    def parseDictRec(self, obj, ind = 0):
        print("  " * ind + "{")
        for key in list(obj.keys()):
            toCall = self.checkType(obj[key])
            if toCall == None:
                self.printAsSuch(['[TYPE NOT PARSED]', key, obj[key]], ind)
            else:
                print("  " * ind + "{!s}: ".format(obj[key]))
                toCall(obj[key] ,ind+1)
        print("  " * ind + "}")
        return None

    def parseDir(self, obj, ind = 0):
        self.parseListRec(obj, ind)

