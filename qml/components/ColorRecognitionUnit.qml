import QtQuick 2.0

Rectangle {
    property alias color: colorDetection.color

    color: "transparent"
    border.color: "gray"
    opacity: 0.4

    Rectangle {
        id: colorRecongnition
        color: "#0e6a8b"
//        opacity: 0.5
        anchors.fill: parent
    }

    Stone {
        id: colorDetection
        height: colorRecongnition.height / 5
        width: height
        y: colorRecongnition.height - height * 1.2
        x: (colorRecongnition.width - width) / 2
        // visible: { color.a > 0 }
    }
}
