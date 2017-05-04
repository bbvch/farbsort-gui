import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3

import ".."

Rectangle {
    id: statisticRect
    color: "white"
    border.color: "transparent"

    RowLayout{
        property int currentRow : 0

        id: titleLayout
        anchors{left:parent.left;right: parent.right; top: parent.top; }
        anchors.rightMargin: Style.smallMargin
        height: 40
        spacing: Style.bigMargin

        Text {
            id:startStopTitle
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.margins: Style.smallMargin
            text: qsTr("Log")
            color: Style.textColor
            font.pixelSize: Style.titleFontSize
        }

        Item{
            id: spacer
            Layout.fillWidth: true
        }

        Button {
            id: previousEventButton
            background: Rectangle{
                anchors.fill: parent
                color: "transparent"
            }

            contentItem: Image {
                source: "qrc:/arrow_up.png"
            }

            onPressed: {
                scale = 0.9
                // get current row on top of tableView -> rowAt needs to be taken of coordinates > 0
                titleLayout.currentRow = eventTableView.tableView.rowAt(10, 10)
                // if top of tableView not yet reached, scroll up
                titleLayout.currentRow = (titleLayout.currentRow < 4) ? 0 : (titleLayout.currentRow - 4)
                eventTableView.tableView.positionViewAtRow(titleLayout.currentRow, ListView.Beginning)
            }
            onReleased: scale = 1.0

            Layout.alignment: Qt.AlignRight
        }

        Button {
            id: nextEventButton
            background: Rectangle{
                anchors.fill: parent
                color: "transparent"
            }

            contentItem: Image {
                source: "qrc:/arrow_down.png"
            }

            onPressed: {
                scale = 0.9
                // get current row on top of tableView -> rowAt needs to be taken of coordinates > 0
                titleLayout.currentRow = eventTableView.tableView.rowAt(10, 10)
                // if bottom of tableView not yet reached, scroll down
                titleLayout.currentRow = (titleLayout.currentRow > (eventTableView.tableView.rowCount - 5)) ? (eventTableView.tableView.rowCount - 1) : (titleLayout.currentRow + 4)
                eventTableView.tableView.positionViewAtRow(titleLayout.currentRow, ListView.Beginning)
            }
            onReleased: scale = 1.0

            Layout.alignment: Qt.AlignRight
        }
    } // RowLayout

    EventTableView {
        id: eventTableView

        anchors{left:parent.left;right: parent.right; bottom: parent.bottom; top: titleLayout.bottom}
        anchors.margins: Style.smallMargin

        Layout.fillHeight: true
        Layout.fillWidth: true
    }
}
