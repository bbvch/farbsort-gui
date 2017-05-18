TEMPLATE = app
TARGET = tst_
CONFIG += warn_on qmltestcase
SOURCES += test/tst_qtquick.cpp

QT += core qml quick

RESOURCES += res/qml.qrc

DISTFILES += \
    test/tst_stone.qml

