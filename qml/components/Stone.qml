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

    function startDetection() {
        stoneObject.x = stoneObject.startPosX
        stoneObject.y = stoneObject.startPosY
        stoneObject.color = "transparent"
        state = "detecting"
    }

    function startEjecting(trayId) {
        if(trayId === stoneObject.trayId) {
            if("moving" === state) {
                state = "moved"
            }
            if("moved" === state && needsEjection()) {
                state = "ejecting"
            }
        }
    }

    function moveConveyor() {
        updateConveyorAnimationTime()
        if("detecting" === state) {
            state = "detected"
        }
        if("detected" === state) {
            state = "moving"
        }
    }

    function onColorDetected(color, trayId, destinationXPos) {
        // stone must be under the color detector and no color was assigned before
        if("detecting" === state && 0 === stoneObject.color.a) {
            stoneObject.color = color
            stoneObject.trayId = trayId
            stoneObject.destinationXPos = destinationXPos - radius
        }
    }

    function onDetectorEndReached() {
        if("detecting" === state) {
            state = "detected"
        }
    }

    // checks if a valid ejector id was set
    function needsEjection() {
        return trayId > 0
    }

    function updateConveyorAnimationTime() {
        conveyorAnimation.duration = conveyorSpeed / (lightbarrierAfterDetectorXPos - startPosX) * (destinationXPos - lightbarrierAfterDetectorXPos)
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
                onRunningChanged: {
                    if(!running) {
                        state = "detected"
                    }
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
                if( running === false)
                {
                    if(needsEjection())
                        state = "moved"
                    else {
                        state = "reached"
                        // stone is moved to garbage bin - set timeout to destroy stone
                        deletionTimer.start()
                    }
                }
            }
        },
        Transition {
            from: "moving";
            to: "moved";
            onRunningChanged: {
                if( running === false)
                {
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
            onRunningChanged: {
                if( running === false)
                {
                    state = "reached"
                }
            }
        }
    ]

    Timer {
        id: deletionTimer
        interval: 10000; running: false; repeat: false
        onTriggered: { stoneObject.destroy(); }
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
                stoneObject.destroy();
            }
        }
    }
}
