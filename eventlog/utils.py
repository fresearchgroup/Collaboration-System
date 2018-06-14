import time
import datetime
from .main import settings as ms

RED = 1
GREEN = 2
BLUE = 3
YELLOW = 4
MAGENTA = 5
IMP_COLOR = 6

LEVEL_COLOR = {
        "IMP": IMP_COLOR,
        "INFO": GREEN,
        "ERROR": RED,
        "WARNING": MAGENTA,
        "DEBUG": BLUE,
        }

COLOR_SEQ = {
         RED: (206, 60, 47),
         GREEN: (66, 244, 200),
         BLUE: (33, 28, 188),
         YELLOW: (175, 132, 22),
         MAGENTA: (255, 0, 255),
         IMP_COLOR: (51, 32, 229),
        } 

def __appendColor(color, custom = False):
    if custom == False:
        return "\033[38;2;" + str(COLOR_SEQ[color][0]) + ";" + str(COLOR_SEQ[color][1]) + ";" + str(COLOR_SEQ[color][2]) + "m"
    elif custom == True:
        return "\033[38;2;" + str(color[0]) + ";" + str(color[1]) + ";" + str(color[2]) + "m"

def __attach_time_stamp():
    ts = time.time()
    st = datetime.datetime.fromtimestamp(ts).strftime("%Y-%m-%d %H:%M:%S")
    return st

def __formatter(level, msg, logclass, color_spec_dic = None):
    color_code = None
    if color_spec_dic == None:
        color_code = LEVEL_COLOR[level]
    else:
        color_code = color_spec_dic['color_code']
    color_str = __appendColor(color_code, True if color_spec_dic != None else False)
    timestamp = __attach_time_stamp()
    fstring = str(color_str) + "[{!s}-{!s}]:{!s}: ".format(timestamp, level, logclass) + str(msg) + "\033[0m"
    return fstring 
        
def ilog(logclass, msg, mode = "INFO", imp = False, color_spec_dic = None):
    if ms.DEBUG == True or imp == True:
        if imp == True:
            mode = "IMP"
            color_spec_dic = None
        print(__formatter(mode, msg, logclass, color_spec_dic))
        


    
