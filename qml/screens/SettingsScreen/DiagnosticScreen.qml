import QtQuick 2.0
import QtQuick.Controls 2.0

import QtQuick.Layouts 1.3

import ".."
import "../.."
import "../../controls"
import "../../components"
import "../../items"


Rectangle {
    id: diagnosticScreen
    color: "#9aa6ac"

    GridLayout{
        id: diagGrid
        anchors.fill: parent
        anchors.margins: Style.bigMargin
        anchors.topMargin: 0
        columns: 4
        rows: 6
        rowSpacing: Style.bigMargin
        columnSpacing: Style.bigMargin

        Simulator {
            id: simulator
            //conveyor.velocity: testControl.conveyorVelocityControl.value
            conveyor.running:                             websocketClient.motorRunning
            lightbarrierBeforeColorDetectionState:        websocketClient.lightbarrierOneState
            lightbarrierAfterColorDetectionState:         websocketClient.lightbarrierTwoState
            lightbarrierTrayOne.lightbarrierInterruted:   websocketClient.lightbarrierThreeState
            lightbarrierTrayTwo.lightbarrierInterruted:   websocketClient.lightbarrierFourState
            lightbarrierTrayThree.lightbarrierInterruted: websocketClient.lightbarrierFiveState
            lightbarrierTrayOne.trayColor:                countingLogic.trayOneStoneCounter.color
            lightbarrierTrayTwo.trayColor:                countingLogic.trayTwoStoneCounter.color
            lightbarrierTrayThree.trayColor:              countingLogic.trayThreeStoneCounter.color

            Component.onCompleted: {
                websocketClient.colorDetected.connect(simulator.onColorDetected)
            }

            Component.onDestruction: {
                websocketClient.colorDetected.disconnect(simulator.onColorDetected)
            }

            Layout.row: 0
            Layout.rowSpan: 4
            Layout.column: 0
            Layout.columnSpan: 3
            Layout.fillHeight: true
            Layout.fillWidth : true
            Layout.preferredWidth: parent.width * 0.75
            Layout.preferredHeight: parent.height * 0.75
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            Layout.margins: 0
        }

        StartStopControl {
            id: startStopControl

            title: qsTr("Testlauf")
            active: websocketClient.motorRunning

            Layout.row: 0
            Layout.rowSpan: 1
            Layout.column: 3
            Layout.columnSpan: 1
            //Layout.fillHeight: true
            Layout.preferredWidth: parent.width/4
            Layout.preferredHeight:simulator.height/5
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            Layout.margins: 0


            onButtonToggled: {
                websocketClient.sendMotorRunningRequest(state)
            }
        }

        TestControl {
            id: testControl

            Layout.row: 1
            Layout.rowSpan: 5
            Layout.column: 3
            Layout.columnSpan: 1
            Layout.fillHeight: true
            Layout.fillWidth : true
            Layout.preferredWidth: parent.width/4
            Layout.preferredHeight:parent.height*4/5
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            Layout.margins: 0
        }

        EventLog {
            id: eventLog

            Layout.row: 4
            Layout.rowSpan: 2
            Layout.column: 0
            Layout.columnSpan: 2
            Layout.fillHeight: true
            Layout.fillWidth : true
            Layout.preferredWidth: parent.width*2/4
            Layout.preferredHeight:parent.height/3
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            Layout.margins: 0
        }

        Statistic {
            id: statisticRect

            Layout.row: 4
            Layout.rowSpan: 2
            Layout.column: 2
            Layout.columnSpan: 1
            Layout.fillHeight: true
            Layout.fillWidth : true
            Layout.preferredWidth: parent.width/4
            Layout.preferredHeight:parent.height/3
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft
            Layout.margins: 0
        }
    } // GridLayout

    LegendContent{
        id:legendContent
        x: 2*Style.bigMargin
        y: simulator.y + simulator.height - height - Style.bigMargin
        width:  simulator.width/3
        height: simulator.height/4

    }
}
