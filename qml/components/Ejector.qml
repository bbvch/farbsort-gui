import QtQuick 2.0

import ".."

Item {
    id: ejector
    width: 40
    height: 150
//    color: "transparent"
//    border.color: "gray"

    readonly property alias state: ejectorPin.state
    property int ejectDistance: height / 3
    property bool valveState: false

    onValveStateChanged: {
        if(valveState) {
            ejectorPin.state = "ejecting";
        } else {
            ejectorPin.state = "pulling";
        }
    }

    Rectangle {
        id: ejectorSleeve
        anchors.fill: parent
        anchors.bottomMargin: Style.bigMargin
        color: "#C4CACD"
        opacity: 0.5
        z:1
    }

    Image {
        id: ejectorPin
        state: "idle"
        anchors.left: parent.left
        anchors.right: parent.right
        y: Style.medMargin
        height: ejectorSleeve.height
        source: "qrc:/ejector.svg"

        states:
            State {
                name: "ejecting"
                PropertyChanges { target: ejectorPin; y: ejector.y+Style.medMargin + ejectDistance }
            }
            State {
                name: "pulling"
                PropertyChanges { target: ejectorPin; y: ejectorSleeve.y+anchors.topMargin }
            }
            State {
                name: "idle"
            }

        transitions: [
            Transition {
                from: "idle";
                to: "ejecting";
                animations: PropertyAnimation { property: "y"; easing.type: Easing.InOutQuad; duration: 150; }
            },
            Transition {
                from: "ejecting";
                to: "pulling";
                animations: PropertyAnimation { property: "y"; easing.type: Easing.InOutQuad; duration: 600; }
                onRunningChanged: {
                    if(!running) {
                        ejectorPin.state = "idle"
                    }
                }
            }
        ]
    }
}
