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

    // true, if mainScreen is shown, otherwise false
    property bool showMainScreen: true

//    visibility: Window.FullScreen

    onShowMainScreenChanged: {
        websocketClient.sendProductionModeRequest(showMainScreen)
    }


    Component {
        id: mainScreenComponent
        MainScreen {
            id: mainScreen
            anchors.fill: parent

            onSettingsScreenRequested: {
                showMainScreen = false
            }
        }
    }

    Component {
        id: settingsScreenComponent
        SettingsScreen {
            id: settingsScreen
            anchors.fill: parent

            onSettingsExitClicked: {
                showMainScreen = true
            }
        }
    }

    Loader {
        id: view
        sourceComponent: showMainScreen ? mainScreenComponent : settingsScreenComponent
        asynchronous: false
        anchors.fill: parent
    }
}
