# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'bagel.ui'
#
# Created by: PyQt5 UI code generator 5.14.0
#
# WARNING! All changes made in this file will be lost!


from PyQt5 import QtCore, QtGui, QtWidgets


class Ui_Dialog(object):
    def setupUi(self, Dialog):
        Dialog.setObjectName("Dialog")
        Dialog.resize(666, 304)
        self.buttonBox = QtWidgets.QDialogButtonBox(Dialog)
        self.buttonBox.setGeometry(QtCore.QRect(120, 250, 521, 32))
        self.buttonBox.setOrientation(QtCore.Qt.Horizontal)
        self.buttonBox.setStandardButtons(QtWidgets.QDialogButtonBox.Cancel|QtWidgets.QDialogButtonBox.Ok)
        self.buttonBox.setObjectName("buttonBox")
        self.sendY_M = QtWidgets.QPushButton(Dialog)
        self.sendY_M.setGeometry(QtCore.QRect(20, 120, 113, 32))
        self.sendY_M.setObjectName("sendY_M")
        self.startY_M = QtWidgets.QPushButton(Dialog)
        self.startY_M.setGeometry(QtCore.QRect(160, 120, 113, 32))
        self.startY_M.setObjectName("startY_M")
        self.stopY_M = QtWidgets.QPushButton(Dialog)
        self.stopY_M.setGeometry(QtCore.QRect(300, 120, 113, 32))
        self.stopY_M.setObjectName("stopY_M")
        self.stopSP = QtWidgets.QPushButton(Dialog)
        self.stopSP.setGeometry(QtCore.QRect(300, 160, 113, 32))
        self.stopSP.setObjectName("stopSP")
        self.startSP = QtWidgets.QPushButton(Dialog)
        self.startSP.setGeometry(QtCore.QRect(160, 160, 113, 32))
        self.startSP.setObjectName("startSP")
        self.sendSP = QtWidgets.QPushButton(Dialog)
        self.sendSP.setGeometry(QtCore.QRect(20, 160, 113, 32))
        self.sendSP.setObjectName("sendSP")
        self.stopU = QtWidgets.QPushButton(Dialog)
        self.stopU.setGeometry(QtCore.QRect(300, 200, 113, 32))
        self.stopU.setObjectName("stopU")
        self.startU = QtWidgets.QPushButton(Dialog)
        self.startU.setGeometry(QtCore.QRect(160, 200, 113, 32))
        self.startU.setObjectName("startU")
        self.sendU_2 = QtWidgets.QPushButton(Dialog)
        self.sendU_2.setGeometry(QtCore.QRect(20, 200, 113, 32))
        self.sendU_2.setObjectName("sendU_2")
        self.Y_Mlabel = QtWidgets.QLabel(Dialog)
        self.Y_Mlabel.setGeometry(QtCore.QRect(430, 130, 60, 16))
        self.Y_Mlabel.setObjectName("Y_Mlabel")
        self.SPlabel = QtWidgets.QLabel(Dialog)
        self.SPlabel.setGeometry(QtCore.QRect(430, 160, 60, 16))
        self.SPlabel.setObjectName("SPlabel")
        self.Ulabel = QtWidgets.QLabel(Dialog)
        self.Ulabel.setGeometry(QtCore.QRect(430, 200, 60, 16))
        self.Ulabel.setObjectName("Ulabel")
        self.UNextlabel = QtWidgets.QLabel(Dialog)
        self.UNextlabel.setGeometry(QtCore.QRect(520, 200, 60, 16))
        self.UNextlabel.setObjectName("UNextlabel")
        self.splitter = QtWidgets.QSplitter(Dialog)
        self.splitter.setGeometry(QtCore.QRect(9, 21, 522, 91))
        self.splitter.setOrientation(QtCore.Qt.Vertical)
        self.splitter.setObjectName("splitter")
        self.positionSlider = QtWidgets.QSlider(self.splitter)
        self.positionSlider.setMaximum(100)
        self.positionSlider.setSingleStep(1)
        self.positionSlider.setOrientation(QtCore.Qt.Horizontal)
        self.positionSlider.setTickPosition(QtWidgets.QSlider.TicksBelow)
        self.positionSlider.setObjectName("positionSlider")
        self.widget = QtWidgets.QWidget(self.splitter)
        self.widget.setObjectName("widget")
        self.horizontalLayout_3 = QtWidgets.QHBoxLayout(self.widget)
        self.horizontalLayout_3.setContentsMargins(0, 0, 0, 0)
        self.horizontalLayout_3.setObjectName("horizontalLayout_3")
        self.SetPoint = QtWidgets.QLabel(self.widget)
        self.SetPoint.setObjectName("SetPoint")
        self.horizontalLayout_3.addWidget(self.SetPoint)
        self.positionValue = QtWidgets.QLabel(self.widget)
        self.positionValue.setObjectName("positionValue")
        self.horizontalLayout_3.addWidget(self.positionValue)
        self.sendSetPoint = QtWidgets.QPushButton(self.widget)
        self.sendSetPoint.setObjectName("sendSetPoint")
        self.horizontalLayout_3.addWidget(self.sendSetPoint)
        self.startSetPoint = QtWidgets.QPushButton(self.widget)
        self.startSetPoint.setObjectName("startSetPoint")
        self.horizontalLayout_3.addWidget(self.startSetPoint)
        self.stopSetPoint = QtWidgets.QPushButton(self.widget)
        self.stopSetPoint.setObjectName("stopSetPoint")
        self.horizontalLayout_3.addWidget(self.stopSetPoint)
        self.widget1 = QtWidgets.QWidget(self.splitter)
        self.widget1.setObjectName("widget1")
        self.horizontalLayout = QtWidgets.QHBoxLayout(self.widget1)
        self.horizontalLayout.setContentsMargins(0, 0, 0, 0)
        self.horizontalLayout.setObjectName("horizontalLayout")
        self.label = QtWidgets.QLabel(self.widget1)
        self.label.setObjectName("label")
        self.horizontalLayout.addWidget(self.label)
        self.uValue = QtWidgets.QLineEdit(self.widget1)
        self.uValue.setMinimumSize(QtCore.QSize(100, 9))
        self.uValue.setMaxLength(5)
        self.uValue.setObjectName("uValue")
        self.horizontalLayout.addWidget(self.uValue)
        self.sendU = QtWidgets.QPushButton(self.widget1)
        self.sendU.setObjectName("sendU")
        self.horizontalLayout.addWidget(self.sendU)

        self.retranslateUi(Dialog)
        QtCore.QMetaObject.connectSlotsByName(Dialog)

    def retranslateUi(self, Dialog):
        _translate = QtCore.QCoreApplication.translate
        Dialog.setWindowTitle(_translate("Dialog", "Bagel Simulator Control"))
        self.sendY_M.setText(_translate("Dialog", "Send Y_M"))
        self.startY_M.setText(_translate("Dialog", "Start Y_M"))
        self.stopY_M.setText(_translate("Dialog", "Stop Y_M"))
        self.stopSP.setText(_translate("Dialog", "Stop SP"))
        self.startSP.setText(_translate("Dialog", "Start SP"))
        self.sendSP.setText(_translate("Dialog", "Send SP"))
        self.stopU.setText(_translate("Dialog", "Stop U"))
        self.startU.setText(_translate("Dialog", "Start U"))
        self.sendU_2.setText(_translate("Dialog", "Send U"))
        self.Y_Mlabel.setText(_translate("Dialog", "_"))
        self.SPlabel.setText(_translate("Dialog", "_"))
        self.Ulabel.setText(_translate("Dialog", "_"))
        self.UNextlabel.setText(_translate("Dialog", "_"))
        self.positionSlider.setToolTip(_translate("Dialog", "Set Position"))
        self.SetPoint.setText(_translate("Dialog", "Set Point"))
        self.positionValue.setText(_translate("Dialog", "0.0"))
        self.sendSetPoint.setText(_translate("Dialog", "Send SetPoint"))
        self.startSetPoint.setText(_translate("Dialog", "Start SetPoint"))
        self.stopSetPoint.setText(_translate("Dialog", "Stop SetPoint"))
        self.label.setText(_translate("Dialog", "U Value:"))
        self.uValue.setText(_translate("Dialog", "0.0"))
        self.sendU.setText(_translate("Dialog", "Send U"))
