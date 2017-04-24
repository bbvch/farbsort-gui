import QtQuick 2.0

Rectangle {
    id: colorRecongnition
    property alias detectedColor: colorDetection.color
    border.color: "gray"
    opacity: 0.4
    color: "#0e6a8b"
    state: "NOTDETECT"

    states: [
        State {
            name: "DETECT"
            PropertyChanges { target: colorRecongnition; color: "yellow"}
        },
        State {
            name: "NOTDETECT"
            PropertyChanges { target: colorRecongnition; color: "#0e6a8b"}
        }
    ]

    transitions: [
        Transition {
            from: "NOTDETECT"
            to: "DETECT"
            ColorAnimation { target: colorRecongnition; duration: 100}
        },
        Transition {
            from: "DETECT"
            to: "NOTDETECT"
            ColorAnimation { target: colorRecongnition; duration: 500}
        }
    ]

    Stone {
        id: colorDetection
        height: colorRecongnition.height / 5
        width: height
        y: colorRecongnition.height - height * 1.2
        x: (colorRecongnition.width - width) / 2
        enabled: false
        // visible: { color.a > 0 }
    }

    // This is used to make the recognized color available in QML
    Rectangle {
        id: recognizedColor
        color: "transparent"
        opacity: 0
    }

    Connections {
        target: websocketClient
        onDetectedColorChanged: {
            recognizedColor.color=color
        }
    }

    // Only change state, if recognized color is not transparent
    // If color != transparent detected, set state to DETECT and reset after 1s
    function onColorDetected() {
        if(recognizedColor.color != "#00000000")
        {
            colorRecongnition.state = "DETECT"
            delayedStateReset(1000)
        }
    }

    Timer {
        id: timer
        onTriggered: resetState()
    }

    function delayedStateReset(delayTime)
    {
        timer.interval = delayTime;
        timer.repeat = false;
        timer.start();
    }

    function resetState() {
        console.log("Reset State...")
        colorRecongnition.state = "NOTDETECT"
    }


    Component.onCompleted: {
        websocketClient.detectedColorChanged.connect(onColorDetected)
    }
}
