import QtQuick 2.0

Item {
    id: lightBarrier
    property bool active: false
    property int lightBeamLength: 100

    Image {
        id: lightSender
        source: active ? "qrc:/lightbarrier_sender_pressed.png" : "qrc:/lightbarrier_sender_default.png"
        anchors.top:   parent.top
        anchors.left:  parent.left
        anchors.right: parent.right
        anchors.bottom: lightBeam.top
        width: parent.width
        height: (parent.height - lightBeam.height) / 2
    }

    Image {
        id: lightBeam
        source: active ? "qrc:/lightbarrier_beam_pressed.png" : "qrc:/lightbarrier_beam_default.png"
        anchors.centerIn: parent
        height: lightBeamLength
        width: parent.width / 3
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Image {
        id: lightReceiver
        source: active ? "qrc:/lightbarrier_receiver_pressed.png" : "qrc:/lightbarrier_receiver_default.png"
        anchors.left:   parent.left
        anchors.right:  parent.right
        anchors.bottom: parent.bottom
        anchors.top: lightBeam.bottom
        width: parent.width
        height: (parent.height - lightBeam.height) / 2
    }
}
