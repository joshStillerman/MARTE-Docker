#!/usr/bin/python
from MDSplus import *
import time
import math

currTime = 0.
shot = 1
idx = 0
while(True):
    time.sleep(0.1)
    currTime = idx * 0.1
    idx = idx + 1
    currVal1 = math.sin(currTime*0.1)
    currVal2 = math.sin(currTime*0.1) * math.cos(currTime*0.033)
    print(currTime)
    Event.stream(shot, 'CH1', Float32(currTime), Float32(currVal1))
