#!/usr/bin/env python3

import sys
import os
from PyQt5.QtWidgets import QApplication, QWidget, QPushButton, QLineEdit
from PyQt5.QtGui import QIcon
from PyQt5.QtCore import pyqtSlot


class App(QWidget):
    def __init__(self):
        super().__init__()
        self.title = "Catt UI"
        self.left = 1800
        self.top = 10
        self.width = 170
        self.height = 100
        self.initUI()

    def initUI(self):
        self.setWindowTitle(self.title)
        self.setGeometry(self.left, self.top, self.width, self.height)

        button = QPushButton("Play", self)
        button.move(10, 10)
        button.clicked.connect(self.play)

        button = QPushButton("Pause", self)
        button.move(70, 10)
        button.clicked.connect(self.pause)

        button = QPushButton("vol up", self)
        button.move(10, 30)
        button.clicked.connect(self.volumeup)

        button = QPushButton("vol down", self)
        button.move(70, 30)
        button.clicked.connect(self.volumedown)

        self.textbox = QLineEdit(self)
        self.textbox.move(10, 50)
        self.textbox.returnPressed.connect(self.seek)

        button = QPushButton("Seek", self)
        button.move(70, 50)
        button.clicked.connect(self.seek)

        button = QPushButton("stop", self)
        button.move(10, 75)
        button.clicked.connect(self.stop)

        self.show()

    @pyqtSlot()
    def pause(self):
        os.system("catt pause")

    def play(self):
        os.system("catt play")

    def stop(self):
        os.system("catt stop")

    def seek(self):
        os.system("catt seek {}".format(self.textbox.text()))

    def volumeup(self):
        os.system("catt volumeup 10")

    def volumedown(self):
        os.system("catt volumedown 10")


if __name__ == "__main__":
    try:
        app = QApplication(sys.argv)
        ex = App()
        sys.exit(app.exec_())
    except KeyboardInterrupt:
        print("Interrupted")
        sys.exit(1)
