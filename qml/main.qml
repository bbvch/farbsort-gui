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

    StackView {
        id: stackView
        initialItem: mainScreen
        anchors.fill: parent

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 400
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 400
            }
        }
        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 400
            }
        }
        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 400
            }
        }
    }

    MainScreen {
        id: mainScreen
        anchors.fill: stackView
    }
}
