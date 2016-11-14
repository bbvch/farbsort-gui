import QtQuick 2.0
import QtQuick.Layouts 1.1

Rectangle {
    id: emergencyButton
    color: "white"

    signal buttonClicked

    Text {
        id:startStopTitle
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 12
        text: "Notfall"
        font.pixelSize: 30
    }

    Image {
        id: backgroundImage
        source: "qrc:/e_stop_background.png"
        fillMode: Image.PreserveAspectFit
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: startStopTitle.bottom
        anchors.bottom: parent.bottom
        anchors.margins: 12
    }

    Rectangle {
        id: e_stop_handle
        anchors.centerIn: backgroundImage
        radius: 50
        width: backgroundImage.height/2
        height: backgroundImage.height/2
        color: "red"
    }

    MouseArea {
        id: e_stop_area
        anchors.fill: backgroundImage

        onPressed: {
            e_stop_handle.color = "crimson"
            e_stop_handle.scale = 0.8
        }

        onReleased: {
            e_stop_handle.color = "red"
            e_stop_handle.scale = 1.0
        }

        onClicked: emergencyButton.buttonClicked()
    }
}