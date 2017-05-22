import QtQuick 2.0

Item {
    id: stoneObject
    state: "CREATED"
    property alias color: circle.color
    property int radius: 20
    height: radius * 2
    width: radius * 2
    property int startPosX: 0
    property int startPosY: 0
    property int stopPosY: startPosY + 5
    property int conveyorSpeed: 800
    property int lightbarrierAfterDetectorXPos: startPosX + 5
    property int trayId: 0
    property int destinationXPos: lightbarrierAfterDetectorXPos * 2
    // flag to store if the color was already assigned
    property date _placedTime: new Date()
    property date _detectedTime:  new Date()
    property date _ejectedTime: new Date()
    property date _reachedTime: new Date()

    // signalizes that the stone is ready for destruction
    signal destructionRequested(var stone)

    // starts the detection of the color
    function handleDetectionStarted() {
        stoneObject._placedTime = new Date()
        stoneObject.x = stoneObject.startPosX - stoneObject.radius
        stoneObject.y = stoneObject.startPosY - stoneObject.radius
        stoneObject.color = "transparent"
        state = "DETECTING"
    }

    // tries to assign the detected color to the stone
    // return: true, if the operation was successful, otherwise false
    function handleColorDetected(color, trayId, destinationXPos) {
        // stone must be under the color detector and no color was assigned before
        if("DETECTING" === state) {
            stoneObject.color = color
            stoneObject.trayId = trayId
            stoneObject.destinationXPos = destinationXPos
            stoneObject.state = "DETECTED"
            console.log("Stone: handled colorDetected event for color " + color)
            return true
        }
        return false
    }

    // tries to move the stone to the end of the detector
    // return: true, if the operation was successful, otherwise false
    function handleDetectorEndReached() {
        if("DETECTED" === state) {
            stoneObject._detectedTime = new Date()
            updateConveyorAnimationTime()
            stoneObject.state = "MOVING"
            console.log("Stone: handled detectorEndReached event")
            return true;
        }
        return false
    }

    function handleStartEjecting(trayId) {
        if(trayId === stoneObject.trayId &&
           ("MOVING" == stoneObject.state || "MOVED" == stoneObject.state)) {
            stoneObject.state = "MOVED"
            if(needsEjection()) {
                stoneObject._ejectedTime = new Date()
                state = "EJECTING"
            }
            return true
        }
        return false
    }

    function handleTrayReached(trayId)
    {
        if(trayId === stoneObject.trayId && "EJECTING" == stoneObject.state) {
            stoneObject._reachedTime = new Date()
            stoneObject.state = "REACHED"
            return true
        }
        return false
    }

    function neededTime() {
        var timeToDetectorEnd = stoneObject._detectedTime - stoneObject._placedTime
        var timeToEjector = stoneObject._ejectedTime - stoneObject._detectedTime
        var timeToEndPosition = stoneObject._reachedTime - stoneObject._ejectedTime
        console.log("timing for stone in tray #" + stoneObject.trayId + ": " + timeToDetectorEnd + ", " + timeToEjector + ", " + timeToEndPosition)
        return stoneObject._reachedTime - stoneObject._placedTime
    }

    // checks if a valid ejector id was set
    function needsEjection() {
        return trayId > 0
    }

    function updateConveyorAnimationTime() {
        var animationTime = stoneObject.conveyorSpeed / (stoneObject.lightbarrierAfterDetectorXPos - stoneObject.startPosX) * (stoneObject.destinationXPos - stoneObject.lightbarrierAfterDetectorXPos)
        //console.info("animationTime from afterDetector to endPosition is " + animationTime)
        conveyorAnimation.duration = animationTime
    }

    function handleReachedTray(trayId) {
        return "REACHED" === stoneObject.state && trayId === stoneObject.trayId
    }

    NumberAnimation {
        id: detectionAnimation
        loops: 1
        alwaysRunToEnd: true
        target: stoneObject
        property: "x"
        from: startPosX - stoneObject.radius
        to: lightbarrierAfterDetectorXPos - stoneObject.radius
        easing.type: Easing.Linear
        duration: conveyorSpeed
        running: false
    }

    NumberAnimation {
        id: conveyorAnimation
        loops: 1
        alwaysRunToEnd: true
        target: stoneObject
        property: "x"
        from: lightbarrierAfterDetectorXPos - stoneObject.radius
        to: destinationXPos - stoneObject.radius
        easing.type: Easing.Linear
        duration: conveyorSpeed
        running: false
    }

    NumberAnimation {
        id: ejectorChipAnimation
        target: stoneObject
        property: "y"
        from: stoneObject.startPosY - stoneObject.radius
        to: stoneObject.stopPosY - stoneObject.radius
        easing.type: Easing.Linear
        duration: 300
        running: false
    }

    states: [
        State { name: "CREATED" },
        State { name: "DETECTING" },
        State { name: "DETECTED" },
        State { name: "MOVING" },
        State { name: "MOVED" },
        State { name: "EJECTING" },
        State { name: "REACHED" }
    ]

    transitions: [
        Transition {
            from: "CREATED";
            to: "DETECTING";
            onRunningChanged: {
                if(!running) {
                    detectionAnimation.start()
                }
            }
        },
        Transition {
            from: "DETECTED"
            to: "MOVING";
            onRunningChanged: {
                // stone is moved to garbage bin - set timeout to destroy stone
                if(!running) {
                    detectionAnimation.complete()
                    conveyorAnimation.start()
                    // TODO: move to animation end
                    if(!needsEjection()) {
                        state = "REACHED"
                        deletionTimer.start()
                    }
                }
            }
        },
        Transition {
            from: "MOVING";
            to: "MOVED";
            onRunningChanged: {
                if(!running) {
                    conveyorAnimation.complete()
                }
            }
        },
        Transition {
            from: "MOVED";
            to: "EJECTING";
            onRunningChanged: {
                if(!running) {
                    ejectorChipAnimation.start()
                }
            }
        },
        Transition {
            from: "EJECTING";
            to: "REACHED";
            onRunningChanged: {
                if(!running) {
                    ejectorChipAnimation.complete()
                }
            }
        }
    ]

    Timer {
        id: deletionTimer
        interval: 10000; running: false; repeat: false
        onTriggered: {
            destructionRequested(stoneObject);
        }
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
                destructionRequested(stoneObject);
            }
        }
    }
}
