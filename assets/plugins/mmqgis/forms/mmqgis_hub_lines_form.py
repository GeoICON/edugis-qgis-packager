# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'mmqgis_hub_lines_form.ui'
#
# Created: Sun Feb  1 18:43:48 2015
#      by: PyQt4 UI code generator 4.9.3
#
# WARNING! All changes made in this file will be lost!

from PyQt4 import QtCore, QtGui

try:
    _fromUtf8 = QtCore.QString.fromUtf8
except AttributeError:
    _fromUtf8 = lambda s: s

class Ui_mmqgis_hub_lines_form(object):
    def setupUi(self, mmqgis_hub_lines_form):
        mmqgis_hub_lines_form.setObjectName(_fromUtf8("mmqgis_hub_lines_form"))
        mmqgis_hub_lines_form.setWindowModality(QtCore.Qt.ApplicationModal)
        mmqgis_hub_lines_form.setEnabled(True)
        mmqgis_hub_lines_form.resize(497, 236)
        mmqgis_hub_lines_form.setMouseTracking(False)
        self.buttonBox = QtGui.QDialogButtonBox(mmqgis_hub_lines_form)
        self.buttonBox.setGeometry(QtCore.QRect(170, 200, 160, 26))
        self.buttonBox.setOrientation(QtCore.Qt.Horizontal)
        self.buttonBox.setStandardButtons(QtGui.QDialogButtonBox.Cancel|QtGui.QDialogButtonBox.Ok)
        self.buttonBox.setObjectName(_fromUtf8("buttonBox"))
        self.label = QtGui.QLabel(mmqgis_hub_lines_form)
        self.label.setGeometry(QtCore.QRect(10, 130, 261, 22))
        self.label.setObjectName(_fromUtf8("label"))
        self.label_3 = QtGui.QLabel(mmqgis_hub_lines_form)
        self.label_3.setGeometry(QtCore.QRect(250, 10, 171, 22))
        self.label_3.setObjectName(_fromUtf8("label_3"))
        self.filename = QtGui.QLineEdit(mmqgis_hub_lines_form)
        self.filename.setGeometry(QtCore.QRect(10, 150, 361, 31))
        self.filename.setText(_fromUtf8(""))
        self.filename.setReadOnly(False)
        self.filename.setObjectName(_fromUtf8("filename"))
        self.browse = QtGui.QPushButton(mmqgis_hub_lines_form)
        self.browse.setGeometry(QtCore.QRect(400, 150, 79, 26))
        self.browse.setObjectName(_fromUtf8("browse"))
        self.hubid = QtGui.QComboBox(mmqgis_hub_lines_form)
        self.hubid.setGeometry(QtCore.QRect(250, 30, 231, 27))
        self.hubid.setObjectName(_fromUtf8("hubid"))
        self.hublayer = QtGui.QComboBox(mmqgis_hub_lines_form)
        self.hublayer.setGeometry(QtCore.QRect(10, 30, 231, 27))
        self.hublayer.setObjectName(_fromUtf8("hublayer"))
        self.label_4 = QtGui.QLabel(mmqgis_hub_lines_form)
        self.label_4.setGeometry(QtCore.QRect(10, 10, 161, 22))
        self.label_4.setObjectName(_fromUtf8("label_4"))
        self.spokelayer = QtGui.QComboBox(mmqgis_hub_lines_form)
        self.spokelayer.setGeometry(QtCore.QRect(10, 90, 231, 27))
        self.spokelayer.setObjectName(_fromUtf8("spokelayer"))
        self.label_5 = QtGui.QLabel(mmqgis_hub_lines_form)
        self.label_5.setGeometry(QtCore.QRect(250, 70, 171, 22))
        self.label_5.setObjectName(_fromUtf8("label_5"))
        self.label_6 = QtGui.QLabel(mmqgis_hub_lines_form)
        self.label_6.setGeometry(QtCore.QRect(10, 70, 161, 22))
        self.label_6.setObjectName(_fromUtf8("label_6"))
        self.spokehubid = QtGui.QComboBox(mmqgis_hub_lines_form)
        self.spokehubid.setGeometry(QtCore.QRect(250, 90, 231, 27))
        self.spokehubid.setObjectName(_fromUtf8("spokehubid"))

        self.retranslateUi(mmqgis_hub_lines_form)
        QtCore.QObject.connect(self.buttonBox, QtCore.SIGNAL(_fromUtf8("accepted()")), mmqgis_hub_lines_form.accept)
        QtCore.QObject.connect(self.buttonBox, QtCore.SIGNAL(_fromUtf8("rejected()")), mmqgis_hub_lines_form.reject)
        QtCore.QMetaObject.connectSlotsByName(mmqgis_hub_lines_form)

    def retranslateUi(self, mmqgis_hub_lines_form):
        mmqgis_hub_lines_form.setWindowTitle(QtGui.QApplication.translate("mmqgis_hub_lines_form", "Hub Lines", None, QtGui.QApplication.UnicodeUTF8))
        self.label.setText(QtGui.QApplication.translate("mmqgis_hub_lines_form", "Output Shapefile", None, QtGui.QApplication.UnicodeUTF8))
        self.label_3.setText(QtGui.QApplication.translate("mmqgis_hub_lines_form", "Hub ID Attribute", None, QtGui.QApplication.UnicodeUTF8))
        self.browse.setText(QtGui.QApplication.translate("mmqgis_hub_lines_form", "Browse...", None, QtGui.QApplication.UnicodeUTF8))
        self.label_4.setText(QtGui.QApplication.translate("mmqgis_hub_lines_form", "Hub Point Layer", None, QtGui.QApplication.UnicodeUTF8))
        self.label_5.setText(QtGui.QApplication.translate("mmqgis_hub_lines_form", "Spoke Hub ID Attribute", None, QtGui.QApplication.UnicodeUTF8))
        self.label_6.setText(QtGui.QApplication.translate("mmqgis_hub_lines_form", "Spoke Point Layer", None, QtGui.QApplication.UnicodeUTF8))

