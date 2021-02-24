from PyQt5 import QtWidgets, QtGui,QtCore

from bagel import Ui_Dialog
import MDSplus
import numpy as np

import numpy as np
import sys

def sendStream(shot, chanName, time, values):
  timeSer = time.serialize()
  valuesSer = values.serialize()
  msg = bytearray(str(shot)+' '+chanName + ' B '+str(len(timeSer))+' ', 'utf8')
  msg.extend(timeSer.data())
  msg.extend(valuesSer.data())
  MDSplus.Event.seteventRaw('STREAMING',np.array(msg))

class mywindow(QtWidgets.QDialog):

    def __init__(self, y_m, u, set_point):

        super(mywindow, self).__init__()

        self.ui = Ui_Dialog()

        self.ui.setupUi(self)
        self.ctrl_index = 0
        self.sim_index = 0
        self.ctrl_time = 0.0
        self.sim_time = 0.0
        self.y_m = y_m
        self.u = u
        self.set_point = set_point
        self.ui.sendSetPoint.clicked.connect(self.sendSetPoint)
        self.ui.startSetPoint.clicked.connect(self.startSetPoint)
        self.ui.stopSetPoint.clicked.connect(self.stopSetPoint)
        self.ui.positionSlider.valueChanged.connect(self.posChanged)
        self.ui.sendY_M.clicked.connect(self.sendY_M)
        self.ui.startY_M.clicked.connect(self.startY_M)
        self.ui.stopY_M.clicked.connect(self.stopY_M)
        self.ui.sendU.clicked.connect(self.sendUValue)
        self.ui.sendU_2.clicked.connect(self.sendU)
        self.ui.startU.clicked.connect(self.startU)
        self.ui.stopU.clicked.connect(self.stopU)
        self.ui.sendSP.clicked.connect(self.sendSP)
        self.ui.startSP.clicked.connect(self.startSP)
        self.ui.stopSP.clicked.connect(self.stopSP)
        self.ui.Y_Mlabel.setText(str(y_m[0,self.ctrl_index]))
        self.ui.SPlabel.setText(str(set_point[self.ctrl_index]))
        self.ui.Ulabel.setText(str(u[self.ctrl_index]))

        self.time = 0.0

    def posChanged(self):
        self.ui.positionValue.setText(str(self.ui.positionSlider.value()/100.))

    def sendUValue(self):
        u = float(self.ui.uValue.text())
        MDSplus.Event.stream(0, 'U', MDSplus.Float32(self.time), MDSplus.Float64(u))

    def sendSetPoint(self):
        MDSplus.Event.stream(0, 'SETPOINT', MDSplus.Float32(self.time), MDSplus.Float64(self.ui.positionSlider.value()/100.))

    def startSetPoint(self):
        pass

    def stopSetPoint(self):
        pass

    def sendY_M(self):
        row = self.y_m[:,self.sim_index]
        sendStream(0, 'Y_M', MDSplus.Float32(self.sim_time), MDSplus.Float64Array(self.y_m[:,self.sim_index]))
        MDSplus.Event.stream(0, 'SETPOINT', MDSplus.Float32(self.sim_time), MDSplus.Float64(self.set_point[self.sim_index]))
        self.sim_index += 1
        self.ui.Y_Mlabel.setText(str(self.y_m[0, self.sim_index]))
        self.sim_time += .01
    def startY_M(self):
        pass
    def stopY_M(self):
        pass

    def sendU(self):
        if self.sim_index >= len(self.u):
            self.sim_index=0
            self.sim_time=0.0
        MDSplus.Event.stream(0, 'U', MDSplus.Float32(self.sim_time), MDSplus.Float64(self.u[self.sim_index]))
        self.ui.Ulabel.setText(str(self.u[self.sim_index]))
        self.sim_index += 1
        self.ui.UNextlabel.setText(str(self.u[self.sim_index]))
        self.sim_time += .01
    
    def startU(self):
        pass
    def stopU(self):
        pass

    def sendSP(self):
        pass
    def stopSP(self):
        pass
    def startSP(self):
        pass


app = QtWidgets.QApplication([])

tree = MDSplus.Tree('simulink', -1)
y_m = tree.Y_M.data()
u = tree.U.data()
set_point = tree.SET_POINT.data()

application = mywindow(y_m, u, set_point)

application.show()

sys.exit(app.exec())
