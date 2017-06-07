import QtQuick 2.0

Item {
    id: tray
    width: 100
    height: 150

    property bool lightbarrierInterruted: false
    property alias trayColor: trayRect.color
    property int trayRectVerticalMiddle: trayRect.y + trayRect.height / 2

    Rectangle {
        id: backgroundChannel
        width: parent.width
        anchors.top: parent.top
        anchors.bottom: trayRect.top
        anchors.horizontalCenter: parent.horizontalCenter
        color: "lightgray"
    }

    Rectangle {
        id: trayRect
        color: "white"
        border.color: "lightgrey"
        border.width: 1
        radius: 4
        width: parent.width
        height: parent.height * .33
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
    }

    LightBarrier {
        id:lightBarrier
        width: trayRect.height / 2
        height: trayRect.width + 2 * 20
        rotation: 90
        active: lightbarrierInterruted
        lightBeamLength: trayRect.width
        anchors.centerIn: trayRect
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
