import QtQuick 2.0
import QtQuick.Controls 2.0

import "../components"

Item {
    id: tray
    width: 100
    height: 150

    property bool lightbarrierInterruted: false
    property alias trayColor: trayRect.color
    property int trayId: 0
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

        MouseArea {
            anchors.fill: parent
            onClicked: {
                colorPopup.color = trayRect.color
                colorPopup.open()
            }
        }

        ChooseTrayColor {
            id: colorPopup
            height: parent.height
            width: parent.width * 3

            onClosed: {
                if (1 === trayId) {
                    countingLogic.trayOneStoneCounter.color = colorPopup.color
                } else if (2 === trayId) {
                    countingLogic.trayTwoStoneCounter.color = colorPopup.color
                } else if (3 === trayId) {
                    countingLogic.trayThreeStoneCounter.color = colorPopup.color
                }
            }
        }
    }

    LightBarrier {
        id:lightBarrier
        width: trayRect.height / 2
        height: trayRect.width + 2 * 20
        rotation: 90
        active: lightbarrierInterruted
        lightBeamLength: trayRect.width
        anchors.centerIn: trayRect
        Rectangle{
            id: trayColor
            color: "white"
        }
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
