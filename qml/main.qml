import QtQuick 2.5
import QtQuick.Window 2.2
import QtQuick.Controls 2.0

import "items"
import "screens"
import "screens/MainScreen"
import "controls"
import "components"


Window {
    title: qsTr("Swiss Top Sort")
    width: 1024
    height: 768
    visible: true

//    visibility: Window.FullScreen

    StackView {
        id: mainStackView
        initialItem: mainScreen
        anchors.fill: parent

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 300
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 300
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 300
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 300
            }
        }
    }

    Component {
        id: simulatorComponent
        Simulator {
            id: simulator
            connected:                                    websocketClient.connected
            //conveyor.velocity: testControl.conveyorVelocityControl.value
            conveyor.running:                             websocketClient.motorRunning
            lightbarrierBeforeColorDetectionState:        websocketClient.lightbarrierOneState
            lightbarrierAfterColorDetectionState:         websocketClient.lightbarrierTwoState
            lightbarrierTrayOne.lightbarrierInterruted:   websocketClient.lightbarrierThreeState
            lightbarrierTrayTwo.lightbarrierInterruted:   websocketClient.lightbarrierFourState
            lightbarrierTrayThree.lightbarrierInterruted: websocketClient.lightbarrierFiveState
            lightbarrierTrayOne.trayColor:                countingLogic.trayOneColor
            lightbarrierTrayTwo.trayColor:                countingLogic.trayTwoColor
            lightbarrierTrayThree.trayColor:              countingLogic.trayThreeColor

            Component.onCompleted: {
                websocketClient.colorDetected.connect(simulator.onColorDetected)
            }
        }
    }

    MainScreen {
        id: mainScreen
        simulatorComponent.sourceComponent: simulatorComponent

        onSettingsScreenRequested: {
            mainStackView.push(settingsScreen)
            websocketClient.sendProductionModeRequest(false)
        }
    }

    SettingsScreen {
        id: settingsScreen
        visible: false
        simulatorComponent.sourceComponent: simulatorComponent

        onSettingsExitClicked: {
            mainStackView.pop(mainScreen)
            websocketClient.sendProductionModeRequest(true)
        }
    }
}
