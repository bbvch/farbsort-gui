import QtQuick 2.0

Item {
    id: stoneObject
    state: "created"
    property alias color: circle.color
    property int startPosX: 16
    property int startPosY: parent.height/2 - stoneObject.height/2
    property int stopPosY: startPosY + 100
    property int conveyorSpeed: 800
    property int lightbarrierAfterDetectorXPos: 300
    property int trayId: 0
    property int destinationXPos: 300
    // reference to the stoneHandler - needed to remove the stone
    property var _stoneHandler: null
    // flag to store if the color was already assigned
    property bool _colorAssigned: false

    function startDetection() {
        stoneObject.x = stoneObject.startPosX
        stoneObject.y = stoneObject.startPosY
        stoneObject.color = "transparent"
        state = "detecting"
    }

    // tries to assign the detected color to the stone
    // return: true, if the operation was successful, otherwise false
    function handleColorDetected(color, trayId, destinationXPos) {
        // stone must be under the color detector and no color was assigned before
        if("detecting" === state && !stoneObject._colorAssigned) {
            stoneObject.color = color
            stoneObject.trayId = trayId
            stoneObject.destinationXPos = destinationXPos - radius
            stoneObject._colorAssigned = true
            console.log("Stone: handled colorDetected event for color " + color)
            return true
        }
        return false
    }

    // tries to move the stone to the end of the detector
    // return: true, if the operation was successful, otherwise false
    function handleDetectorEndReached() {
        if("detecting" === state) {
            stoneObject.state = "detected"
            updateConveyorAnimationTime()
            stoneObject.state = "moving"

            console.log("Stone: handled detectorEndReached event")
            return true;
        }
        return false
    }

    function startEjecting(trayId) {
        if(trayId === stoneObject.trayId &&
           ("moving" == stoneObject.state || "moved" == stoneObject.state)) {
            stoneObject.state = "moved"
            if(needsEjection()) {
                state = "ejecting"
            }
            return true
        }
        return false
    }

    function handleTrayReached(trayId)
    {
        if(trayId === stoneObject.trayId && "ejecting" == stoneObject.state) {
            stoneObject.state = "reached"
            return true
        }
        return false
    }

    // checks if a valid ejector id was set
    function needsEjection() {
        return trayId > 0
    }

    function updateConveyorAnimationTime() {
        conveyorAnimation.duration = conveyorSpeed / (lightbarrierAfterDetectorXPos - startPosX) * (destinationXPos - lightbarrierAfterDetectorXPos)
    }

    function reachedTray(trayId) {
        return "reached" === stoneObject.state && trayId === stoneObject.trayId
    }

    states: [
        State { name: "created" },
        State { name: "detecting" },
        State { name: "detected" },
        State { name: "moving" },
        State { name: "moved" },
        State { name: "ejecting" },
        State { name: "reached" }
    ]

    transitions: [
        Transition {
            from: "created";
            to: "detecting";
            animations:     PropertyAnimation {
                id: detectionAnimation
                loops: 1
                alwaysRunToEnd: true
                target: stoneObject
                property: "x"
                from: startPosX
                to: lightbarrierAfterDetectorXPos
                easing.type: Easing.Linear
                duration: conveyorSpeed
            }
        },
        Transition {
            from: "detecting";
            to: "detected";
            onRunningChanged: {
                if(!running) {
                    detectionAnimation.complete()
                    stoneObject.x = lightbarrierAfterDetectorXPos
                }
            }
        },
        Transition {
            from: "detected";
            to: "moving";
            animations: NumberAnimation {
                id: conveyorAnimation
                loops: 1
                alwaysRunToEnd: true
                target: stoneObject
                property: "x"
                from: lightbarrierAfterDetectorXPos
                to: destinationXPos
                easing.type: Easing.Linear
                duration: conveyorSpeed //conveyorAnimationTime()
            }
            onRunningChanged: {
                // stone is moved to garbage bin - set timeout to destroy stone
                if(!running && !needsEjection()) {
                    state = "reached"
                    deletionTimer.start()
                }
            }
        },
        Transition {
            from: "moving";
            to: "moved";
            onRunningChanged: {
                if(!running) {
                    conveyorAnimation.complete()
                    stoneObject.x = conveyorAnimation.to
                }
            }
        },
        Transition {
            from: "moved";
            to: "ejecting";
            animations: NumberAnimation {
                id: ejectorChipAnimation
                target: stoneObject
                property: "y"
                from: stoneObject.startPosY
                to: stoneObject.stopPosY
                easing.type: Easing.Linear
                duration: 300
            }
        },
        Transition {
            from: "ejecting";
            to: "reached";
            onRunningChanged: {
                if(!running) {
                    ejectorChipAnimation.complete()
                    stoneObject.y = stoneObject.stopPosY
                }
            }
        }
    ]

    Timer {
        id: deletionTimer
        interval: 10000; running: false; repeat: false
        onTriggered: { _stoneHandler.removeStone(stoneObject); }
    }

    Rectangle {
        id: circle
        anchors.fill: parent
        radius: 90
        color: "transparent"
        border.color: "black"
        border.width: parent.width * 0.05

        MouseArea {
            anchors.fill: parent
            onClicked: {
                _stoneHandler.removeStone(stoneObject);
            }
        }
    }
}
