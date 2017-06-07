import QtQuick 2.0

import ".."

Item {
    id: conveyor
    width: 610
    height: 100

    property bool running: false
    property double velocity: 1.0

    Rectangle {
        id: conveyorArea
        anchors.fill: parent
        anchors.margins: Style.smallMargin
        color: "#eceff1"

        property int numberOfElements: 27
        property int beltElementWidth: conveyor.width / 70
        property double offsetBetweenBeltElements: conveyor.width / numberOfElements

        signal resized

        onWidthChanged: {
            resized()
        }

        Row {
            spacing: conveyorArea.beltElementWidth*2

            Repeater {
                id: repeater
                model: conveyorArea.numberOfElements
                delegate:
                    Rectangle {
                        id: beltElement
                        y: 0
                        x: startPosition
                        width: conveyorArea.beltElementWidth
                        height: conveyorArea.height
                        color: "#b0bec5"

                        property int index: modelData
                        readonly property double startPosition: index * conveyorArea.offsetBetweenBeltElements

                        function restartAnimation() {
                            animation.restart()
                            if(!conveyor.running) {
                                animation.stop()
                            }
                        }

                        SequentialAnimation on x {
                            id: animation
                            loops: Animation.Infinite
                            running: conveyor.running

                            PropertyAnimation {
                                from: beltElement.startPosition
                                to: beltElement.startPosition + conveyorArea.offsetBetweenBeltElements
                                duration: 1000 / conveyor.velocity;
                            }
                        }

                        Component.onCompleted: {
                            conveyorArea.resized.connect(restartAnimation)
                        }
                    }
            }
        }
    }
}
