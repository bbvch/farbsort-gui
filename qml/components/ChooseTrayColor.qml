import QtQuick 2.0
import QtQuick.Controls 2.0

Popup {
    id: root
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
    margins: 0
    padding: 1

    property color color: "blue"

    ListModel {
        id: colors
        ListElement { color: "blue" }
        ListElement { color: "red" }
        ListElement { color: "white" }
    }

    Row {
        Repeater {
            model: colors
            delegate: Rectangle {
                id: field
                width: root.width / colors.count
                height: root.height
                color: modelData

                MouseArea {
                    anchors.fill: field
                    onClicked: {
                        root.color = field.color
                        root.close()
                    }
                }
            }
        }
    }
}
