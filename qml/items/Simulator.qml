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

    width: Dimensions.simulatorWidth
    height: Dimensions.simulatorHeight

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
                finalPosition = Dimensions.ejectorOneHorizontalCenterFactor * simulator.width
                trayId = 1
            } else if(color === lightbarrierTrayTwo.trayColor) {
                finalPosition = Dimensions.ejectorTwoHorizontalCenterFactor * simulator.width
                trayId = 2
            } else if(color === lightbarrierTrayThree.trayColor) {
                finalPosition = Dimensions.ejectorThreeHorizontalCenterFactor * simulator.width
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

        height: Dimensions.conveyorHeightFactor * parent.height
        width: Dimensions.conveyorWidthFactor * parent.width
        y: Dimensions.conveyorVerticalCenterFactor * parent.height - height / 2
        //anchors.left: parent.left
        //anchors.right: unidentifiedObjectBin.left
        anchors.leftMargin: Style.smallMargin
        anchors.rightMargin: Style.smallMargin

        velocity: 5.7
    }

    Rectangle {
        id: unidentifiedObjectBin

        height: Dimensions.undefinedBinHeightFactor * parent.height
        width:  Dimensions.undefinedBinWidthFactor * parent.width
        anchors.verticalCenter: conveyor.verticalCenter
        anchors.left: conveyor.right
        anchors.right: parent.right
        anchors.rightMargin: Style.smallMargin

        radius: 4
        border.color: "lightgray"
        color: "#eceff1"
        border.width: 1
    }

    LightBarrier {
        id: bevorColorRecognition
        active:  lightbarrierBeforeColorDetectionState

        height: Dimensions.lightbarrierOneTwoHeightFactor * parent.height
        width: Dimensions.lightbarrierOneTwoWidthFactor * parent.width
        anchors.verticalCenter: conveyor.verticalCenter
        x: (Dimensions.sensorOneHorizontalCenterFactor * parent.width) - width / 2

        Text{
            text:"S1"
            color: Style.textColor
            anchors.top: parent.top
            anchors.right: parent.left
        }
    }

    ColorRecognitionUnit {
        id: colorRecongnition
        color: "red"

        width: Dimensions.colorDetectorWidthFactor * parent.width
        height: Dimensions.colorDetectorHeightFactor * parent.height
        anchors.verticalCenter: conveyor.verticalCenter
        x: (Dimensions.colorDetectorHorizontalCenterFactor * parent.width) - width / 2

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

        height: Dimensions.lightbarrierOneTwoHeightFactor * parent.height
        width: Dimensions.lightbarrierOneTwoWidthFactor * parent.width
        anchors.verticalCenter: conveyor.verticalCenter
        x: (Dimensions.sensorTwoHorizontalCenterFactor * parent.width) - width / 2

        Text{
            text:"S2"
            color: Style.textColor
            anchors.top: parent.top
            anchors.right: parent.left
        }
    }

    Ejector {
        id: ejectorOne


        height: Dimensions.ejectorHeightFactor * parent.height
        width: Dimensions.ejectorWidthFactor * parent.width
        anchors.bottom: conveyor.top
        x: Dimensions.ejectorOneHorizontalCenterFactor * parent.width - width / 2

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

        height: Dimensions.ejectorHeightFactor * parent.height
        width: Dimensions.ejectorWidthFactor * parent.width
        anchors.bottom: conveyor.top
        x: Dimensions.ejectorTwoHorizontalCenterFactor * parent.width - width / 2

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

        height: Dimensions.ejectorHeightFactor * parent.height
        width: Dimensions.ejectorWidthFactor * parent.width
        anchors.bottom: conveyor.top
        x: Dimensions.ejectorThreeHorizontalCenterFactor * parent.width - width / 2

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

        height: Dimensions.slideHeightFactor * parent.height
        width: Dimensions.slideWidthFactor * parent.height
        anchors.top: conveyor.bottom
        x: Dimensions.ejectorOneHorizontalCenterFactor * parent.width - width / 2

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
        trayColor: "red"
        lightbarrierInterruted: false

        height: Dimensions.slideHeightFactor * parent.height
        width: Dimensions.slideWidthFactor * parent.height
        anchors.top: conveyor.bottom
        x: Dimensions.ejectorTwoHorizontalCenterFactor * parent.width - width / 2


        Text{
            text:"S4"
            color: Style.textColor
            anchors.top: parent.bottom
            anchors.topMargin: -Style.smallMargin
            anchors.left: parent.right
            anchors.leftMargin: -(3*Style.smallMargin)
        }
    }


    Tray {
        id: lightbarrierTrayThree
        trayColor: "lightblue"
        lightbarrierInterruted: false

        height: Dimensions.slideHeightFactor * parent.height
        width: Dimensions.slideWidthFactor * parent.height
        anchors.top: conveyor.bottom
        x: Dimensions.ejectorThreeHorizontalCenterFactor * parent.width - width / 2

        Text{
            text:"S5"
            color: Style.textColor
            anchors.top: parent.bottom
            anchors.topMargin: -Style.smallMargin
            anchors.left: parent.right
            anchors.leftMargin: -(3*Style.smallMargin)
        }
    }

    Component {
        id: preconfigureStone

        Stone {
            id: stoneInstance
            radius:             Dimensions.stoneWidthFactor * parent.width / 2
            startPosX:          Dimensions.sensorOneHorizontalCenterFactor * parent.width
            startPosY:          conveyor.y + conveyor.height / 2
            stopPosY:           lightbarrierTrayOne.y + lightbarrierTrayOne.trayRectVerticalMiddle
            lightbarrierAfterDetectorXPos: Dimensions.sensorTwoHorizontalCenterFactor * parent.width
            destinationXPos:    unidentifiedObjectBin.x + unidentifiedObjectBin.width / 2
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
            var timeNeeded = StoneHandler.trayReached(1)
            if(timeNeeded) {
                countingLogic.stoneReachedInTray(1, timeNeeded);
            }
        } else {
            StoneHandler.removeStonesFromTray(1)
        }
    }

    // when stone is removed from tray two all stones in the tray are removed
    readonly property bool trayTwoActivated: lightbarrierTrayTwo.lightbarrierInterruted
    onTrayTwoActivatedChanged: {
        if(trayTwoActivated) {
            var timeNeeded = StoneHandler.trayReached(2)
            if(timeNeeded) {
                countingLogic.stoneReachedInTray(2, timeNeeded);
            }
        } else {
            StoneHandler.removeStonesFromTray(2)
        }
    }

    // when stone is removed from tray three all stones in the tray are removed
    readonly property bool trayThreeActivated: lightbarrierTrayThree.lightbarrierInterruted
    onTrayThreeActivatedChanged: {
        if(trayThreeActivated) {
            var timeNeeded = StoneHandler.trayReached(3)
            if(timeNeeded) {
                countingLogic.stoneReachedInTray(3, timeNeeded);
            }
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
