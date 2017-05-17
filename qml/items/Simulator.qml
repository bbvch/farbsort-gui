import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQml 2.0

import ".."
import "../components"

import "StoneHandler.js" as StoneHandler

Rectangle {
    id: simulator
    color: "white"

    property bool connected: false
    property alias conveyor: conveyor
    property alias ejectorOne: ejectorOne
    property alias ejectorTwo: ejectorTwo
    property alias ejectorThree: ejectorThree
    property bool  lightbarrierBeforeColorDetectionState: false
    property bool  lightbarrierAfterColorDetectionState: false
    property alias lightbarrierTrayOne: lightbarrierTrayOne
    property alias lightbarrierTrayTwo: lightbarrierTrayTwo
    property alias lightbarrierTrayThree: lightbarrierTrayThree

    onConnectedChanged: {
        // remove all stones when disconnected
        if(!connected) {
            StoneHandler.removeAllStones()
        }
    }

    // decides to which tray the stone needs to be moved
    function onColorDetected(color) {
        if(StoneHandler.running) {
            var finalPosition = unidentifiedObjectBin.x + unidentifiedObjectBin.width / 2
            var trayId = 0
            if(color === lightbarrierTrayOne.trayColor) {
                finalPosition = layoutGrid.x + lightbarrierTrayOne.x + lightbarrierTrayOne.width / 2
                trayId = 1
            } else if(color === lightbarrierTrayTwo.trayColor) {
                finalPosition = layoutGrid.x + lightbarrierTrayTwo.x + lightbarrierTrayTwo.width / 2
                trayId = 2
            } else if(color === lightbarrierTrayThree.trayColor) {
                finalPosition = layoutGrid.x + lightbarrierTrayThree.x + lightbarrierTrayThree.width / 2
                trayId = 3
            }

            StoneHandler.colorDetected(color, trayId, finalPosition)
        }
    }

    Component.onDestruction: {
        StoneHandler.shutdown()
    }


// The Conveyor has to be outside of the grid layout because of gridlayout warning "cell already taken"

    Conveyor {
        id: conveyor
        height: parent.height/8
        anchors.left: parent.left
        anchors.leftMargin: Style.bigMargin
        anchors.right: unidentifiedObjectBin.left
        anchors.rightMargin: Style.bigMargin
        anchors.verticalCenter:   parent.verticalCenter
        velocity: 5.7
    }

    Rectangle {
        id: unidentifiedObjectBin
        height: parent.height/8
        width:  parent.height/8
        radius: 4
        border.color: "lightgray"
        color: "#eceff1"
        border.width: 1
        anchors.right: parent.right
        anchors.rightMargin: Style.bigMargin
        anchors.verticalCenter: parent.verticalCenter
    }


    GridLayout {
        id: layoutGrid
        anchors.fill: parent
        anchors.margins: Style.bigMargin
        anchors.leftMargin: 2*Style.bigMargin
        rows: 7
        columns: 9
        rowSpacing: 0
        columnSpacing: 0

        Item {
            id:spacer1
//            color: "transparent"
//            border.color: "gray"

            Layout.row: 0
            Layout.rowSpan: 2
            Layout.column: 0
            Layout.columnSpan: 4
            Layout.preferredWidth:parent.width/9
            Layout.preferredHeight: parent.height*2/7
            Layout.alignment: Qt.AlignLeft
            Layout.margins: 0
        }

        LightBarrier {
            id: bevorColorRecognition
            active:  lightbarrierBeforeColorDetectionState

            Layout.row: 2
            Layout.rowSpan: 3
            Layout.column: 0
            Layout.columnSpan: 1
            Layout.preferredWidth:parent.width/24
            Layout.preferredHeight: parent.height*2/7
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.margins: 0
            Layout.rightMargin: Style.bigMargin

            Text{
                text:"S1"
                color: Style.textColor
                anchors.top: parent.top
                anchors.right: parent.left
            }
        }

        Item {
            id:spacer2
//            color: "transparent"
//            border.color: "gray"

            Layout.row: 5
            Layout.rowSpan: 2
            Layout.column: 0
            Layout.columnSpan: 2
            Layout.preferredWidth:parent.width/9
            Layout.preferredHeight: parent.height*2/7
            Layout.alignment: Qt.AlignLeft
            Layout.margins: 0
        }

        ColorRecognitionUnit {
            id: colorRecongnition
            color: "red"

            Layout.row: 2
            Layout.rowSpan: 3
            Layout.column: 1
            Layout.columnSpan: 2
            Layout.preferredWidth: parent.width*2/9
            Layout.preferredHeight: parent.height*2/7
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.margins: 0

            Text{
                text:qsTr("Farberkennung")
                color: Style.textColor
                anchors.bottom: parent.top
                anchors.bottomMargin: Style.smallMargin/2
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

        LightBarrier {
            id: afterColorRecognition
            active: lightbarrierAfterColorDetectionState

            Layout.row: 2
            Layout.rowSpan: 3
            Layout.column: 3
            Layout.columnSpan: 1
            Layout.preferredWidth: parent.width/24
            Layout.preferredHeight: parent.height*2/7
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.margins: 0

            Text{
                text:"S2"
                color: Style.textColor
                anchors.top: parent.top
                anchors.left: parent.right
            }
        }

        Item {
            id:spacer3
            opacity: 0.5
//            color: "olive"
//            border.color: "gray"

            Layout.row: 3
            Layout.rowSpan: 1
            Layout.column: 4
            Layout.columnSpan: 5
//            Layout.fillWidth : true
            Layout.preferredWidth:parent.width*4/9
            Layout.preferredHeight: parent.height/8
            Layout.alignment: Qt.AlignTop
            Layout.margins: 0
        }

        Ejector {
            id: ejectorOne

            Layout.row: 0
            Layout.rowSpan: 3
            Layout.column: 4
            Layout.columnSpan: 1
            Layout.preferredWidth: 40
            Layout.preferredHeight: parent.height*3/8
            Layout.alignment: Qt.AlignBottom| Qt.AlignHCenter
            Layout.margins: 0
            ejectDistance: conveyor.height/2

            Text{
                text:"A1"
                color: Style.textColor
                anchors.top: parent.top
                anchors.left: parent.right
                anchors.leftMargin: Style.smallMargin
            }

            valveState: websocketClient.valve1State
        }

        Ejector {
            id: ejectorTwo

            Layout.row: 0
            Layout.rowSpan: 3
            Layout.column: 5
            Layout.columnSpan: 1
            Layout.preferredWidth: 40
            Layout.preferredHeight: parent.height*3/8
            Layout.alignment: Qt.AlignBottom| Qt.AlignHCenter
            Layout.margins: 0
            ejectDistance: conveyor.height/2

            Text{
                text:"A2"
                color: Style.textColor
                anchors.top: parent.top
                anchors.left: parent.right
                anchors.leftMargin: Style.smallMargin
            }

            valveState: websocketClient.valve2State
        }

        Ejector {
            id: ejectorThree
            Layout.fillHeight: false
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

            Layout.row: 0
            Layout.rowSpan: 3
            Layout.column: 6
            Layout.columnSpan: 1
            Layout.preferredWidth: 40
            Layout.preferredHeight: parent.height*3/8
            Layout.margins: 0
            ejectDistance: conveyor.height/2

            Text{
                text:"A3"
                color: Style.textColor
                anchors.top: parent.top
                anchors.left: parent.right
                anchors.leftMargin: Style.smallMargin
            }

            valveState: websocketClient.valve3State
        }

        Tray {
            id: lightbarrierTrayOne
            trayColor: "white"
            lightbarrierInterruted: false

            Layout.row: 4
            Layout.rowSpan: 2
            Layout.column: 4
            Layout.columnSpan: 1
            Layout.preferredWidth: parent.width*3/18
            Layout.preferredHeight: parent.height / 3
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            Layout.margins: 0
            Layout.bottomMargin: 5

            Text{
                text:"S3"
                color: Style.textColor
                anchors.top: parent.bottom
                anchors.topMargin: -Style.smallMargin
                anchors.left: parent.right
                anchors.leftMargin: -(3*Style.smallMargin)
            }
        }

        Tray {
            id: lightbarrierTrayTwo
            width: 40
            trayColor: "red"
            lightbarrierInterruted: false
            Layout.row: 4
            Layout.rowSpan: 2
            Layout.column: 5
            Layout.columnSpan: 1
            Layout.preferredWidth: parent.width*3/18
            Layout.preferredHeight: parent.height / 3
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            Layout.margins: 0
            Layout.bottomMargin: 5

            Text{
                text:"S4"
                color: Style.textColor
                anchors.top: parent.bottom
                anchors.topMargin: -Style.smallMargin
                anchors.left: parent.right
                anchors.leftMargin: -(3*Style.smallMargin)
            }
        }

        Item {
            id: spacer5
//            color: "transparent"
//            border.color: "gray"

            Layout.row: 6
            Layout.rowSpan: 1
            Layout.column: 5
            Layout.columnSpan: 1
//            Layout.maximumWidth: 140
            Layout.preferredWidth: parent.width / 7
            Layout.preferredHeight: 5
            Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
            Layout.margins: 0
        }

        Tray {
            id: lightbarrierTrayThree
            trayColor: "lightblue"
            lightbarrierInterruted: false
            Layout.row: 4
            Layout.rowSpan: 2
            Layout.column: 6
            Layout.columnSpan: 1
            Layout.preferredWidth: parent.width*3/18
            Layout.preferredHeight: parent.height / 3
            Layout.margins: 0
            Layout.bottomMargin: 5
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter

            Text{
                text:"S5"
                color: Style.textColor
                anchors.top: parent.bottom
                anchors.topMargin: -Style.smallMargin
                anchors.left: parent.right
                anchors.leftMargin: -(3*Style.smallMargin)
            }
        }

        Item {
            id: spacer6
//            color: "transparent"
//            border.color: "gray"

            Layout.row: 0
            Layout.rowSpan: 3
            Layout.column: 8
            Layout.columnSpan: 1

//            Layout.fillHeight: true
            Layout.preferredWidth: parent.width / 9
            Layout.preferredHeight: parent.height/7
            Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
            Layout.margins: 0
            Layout.bottomMargin: 5
        }

        Item {
            id: spacer7
//            color: "transparent"
//            border.color: "gray"

            Layout.row: 4
            Layout.rowSpan: 3
            Layout.column: 8
            Layout.columnSpan: 1

            Layout.preferredWidth: parent.width / 9
            Layout.preferredHeight: parent.height*2/7
            Layout.alignment: Qt.AlignTop | Qt.AlignHCenter
            Layout.margins: 0
        }
    } // GridLayout

    Component {
        id: preconfigureStone

        Stone {
            id: stoneInstance
            readonly property int diameter: conveyor.height*2 / 3
            readonly property int radius:   diameter  / 2
            height:             diameter
            width:              diameter
            startPosX:          layoutGrid.x + bevorColorRecognition.x + bevorColorRecognition.width / 2 - radius
            startPosY:          conveyor.y + conveyor.height / 2 - radius
            stopPosY:           layoutGrid.y + lightbarrierTrayOne.y + lightbarrierTrayOne.trayRectVerticalMiddle - radius
            conveyorSpeed:      1500
            lightbarrierAfterDetectorXPos: layoutGrid.x + afterColorRecognition.x + afterColorRecognition.width / 2 - radius
            destinationXPos:    unidentifiedObjectBin.x + unidentifiedObjectBin.width / 2 - radius
        }
    }

    // no explicit event for stone placed is available.
    // this is a workaround to place a new stone on the conveyor.
    onLightbarrierBeforeColorDetectionStateChanged: {
        if(lightbarrierBeforeColorDetectionState && conveyor.running) {
            StoneHandler.stonePlaced(preconfigureStone, simulator)
        }
    }

    // lightbarrier is triggered, moves the stone to the position and continues animation
    onLightbarrierAfterColorDetectionStateChanged: {
        if(lightbarrierAfterColorDetectionState)
            StoneHandler.detectorEndReached()
    }

    // when stone is removed from tray one all stones in the tray are removed
    readonly property bool trayOneActivated: lightbarrierTrayOne.lightbarrierInterruted
    onTrayOneActivatedChanged: {
        if(trayOneActivated) {
            StoneHandler.trayReached(1)
        } else {
            StoneHandler.removeStonesFromTray(1)
        }
    }

    // when stone is removed from tray two all stones in the tray are removed
    readonly property bool trayTwoActivated: lightbarrierTrayTwo.lightbarrierInterruted
    onTrayTwoActivatedChanged: {
        if(trayTwoActivated) {
            StoneHandler.trayReached(2)
        } else {
            StoneHandler.removeStonesFromTray(2)
        }
    }

    // when stone is removed from tray three all stones in the tray are removed
    readonly property bool trayThreeActivated: lightbarrierTrayThree.lightbarrierInterruted
    onTrayThreeActivatedChanged: {
        if(trayThreeActivated) {
            StoneHandler.trayReached(3)
        } else {
            StoneHandler.removeStonesFromTray(3)
        }
    }

    // send ejectorOne valve state to stone
    readonly property bool ejectorOneValveState: ejectorOne.valveState
    onEjectorOneValveStateChanged: {
        if(ejectorOneValveState)
            StoneHandler.startEjecting(1)
    }

    // send ejectorTwo valve state to stone
    readonly property bool ejectorTwoValveState: ejectorTwo.valveState
    onEjectorTwoValveStateChanged: {
        if(ejectorTwoValveState)
            StoneHandler.startEjecting(2)
    }

    // send ejectorThree valve state to stone
    readonly property bool ejectorThreeValveState: ejectorThree.valveState
    onEjectorThreeValveStateChanged: {
        if(ejectorThreeValveState)
            StoneHandler.startEjecting(3)
    }
}
