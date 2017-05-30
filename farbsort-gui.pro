TEMPLATE = app
CONFIG   -= app_bundle

QT += core qml quick websockets
CONFIG += c++11

VERSION = 0.1
DEFINES += APP_VERSION=\\\"$$VERSION\\\"

INCLUDEPATH += include

SOURCES += src/main.cpp \
    src/websocketclientimplementation.cpp \
    src/websocketclient.cpp \
    src/websocketclientsimulation.cpp \
    src/countinglogic.cpp \
    src/EventLog.cpp \
    src/stonecounter.cpp

HEADERS += \
    include/websocketclient.h \
    include/websocketclientimplementation.h \
    include/websocketclientsimulation.h \
    include/countinglogic.h \
    include/EventLog.h \
    include/StatisticModel.h \
    include/stonecounter.h

RESOURCES += res/qml.qrc \
    res/images.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
target.path = /opt/$${TARGET}/bin
INSTALLS += target

OTHER_FILES +=

DISTFILES += \
    farbsort-gui_git.bb \
    qml/main.qml \
    qml/components/Conveyor.qml \
    qml/components/Ejector.qml \
    qml/components/Tray.qml \
    qml/screens/MainScreen.qml \
    qml/items/Simulator.qml \
    qml/items/WebSocketClient.qml \
    qml/screens/MainScreen/MainTitleBar.qml \
    qml/controls/TestControl.qml \
    qml/controls/StartStopControl.qml \
    qml/controls/ToggleButton.qml \
    qml/controls/EmergencyButton.qml \
    qml/Style.qml \
    qml/qmldir \
    qml/components/Legend.qml \
    qml/components/Statistic.qml \
    qml/components/Status.qml \
    qml/components/LightBarrier.qml \
    qml/components/Stone.qml \
    qml/components/ColorRecognitionUnit.qml \
    qml/screens/SettingsScreen.qml \
    qml/screens/SettingsScreen/DiagnosticScreen.qml \
    qml/screens/SettingsScreen/SettingsScreenTitle.qml \
    qml/screens/SettingsScreen/ConfigurationScreen.qml \
    qml/components/EventLog.qml \
    qml/components/EventTableView.qml \
    qml/components/LegendContent.qml \
    js/StoneHandler.js \
    qml/AnimationTimes.qml \
    qml/components/ChooseTrayColor.qml

lupdate_only{
SOURCES += $${DISTFILES}
}
