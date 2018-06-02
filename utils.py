import time
import datetime
from main import settings as ms

RED = 1
GREEN = 2
BLUE = 3
YELLOW = 4
MAGENTA = 5

LEVEL_COLOR = {
        "INFO": GREEN,
        "ERROR": RED,
        "WARNING": MAGENTA,
        "DEBUG": BLUE
        }

COLOR_SEQ = {
         RED: (206, 60, 47),
         GREEN: (66, 244, 200),
         BLUE: (33, 28, 188),
         YELLOW: (175, 132, 22),
         MAGENTA: (255, 0, 255)
        }

def __appendColor(color):
    return "\033[38;2;" + str(COLOR_SEQ[color][0]) + ";" + str(COLOR_SEQ[color][1]) + ";" + str(COLOR_SEQ[color][2]) + "m"

def __attach_time_stamp():
    ts = time.time()
    st = datetime.datetime.fromtimestamp(ts).strftime("%Y-%m-%d %H:%M:%S")
    return st

def __formatter(level, msg, logclass):
    color_code = LEVEL_COLOR[level]
    color_str = __appendColor(color_code)
    timestamp = __attach_time_stamp()
    fstring = str(color_str) + "[{!s}-[{!s}]:{!s}: ".format(timestamp, level, logclass) + str(msg) + "\033[0m"
    return fstring

def ilog(logclass, msg, mode = "INFO", imp = False):
    if ms.DEBUG == True or imp == True:
        print(__formatter(mode, msg, logclass)) 


    
