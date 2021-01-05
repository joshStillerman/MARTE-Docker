#!/usr/bin/python3
import MDSplus
import time
import math
import numpy as np

currTime = 0.
shot = 1
idx = 0
while(True):
    time.sleep(0.1)
    currTime = idx * 0.1
    idx = idx + 1
    currVal1 = math.sin(currTime*0.1)
    print(currTime)
    MDSplus.Event.stream(shot, 'MEASURE', MDSplus.Int64Array(np.repeat(int(time.time()*1000), 5)), 
            MDSplus.Float32Array(np.repeat(currVal1, 5)))
