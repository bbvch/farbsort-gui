import QtQuick 2.0
import QtQuick.Layouts 1.3

import ".."

Rectangle {
    id: statisticRect
    color: "white"

    Text {
        id:startStopTitle
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: Style.smallMargin
        text: qsTr("Statistik")
        color: Style.textColor
        font.pixelSize: Style.titleFontSize
    }

    GridLayout{
        id: statisticGrid
        anchors.top: startStopTitle.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: Style.bigMargin
        columns: 4
        rows: 6
        rowSpacing: Style.medMargin
        columnSpacing: Style.bigMargin

        Rectangle{
            id: seperator1
            color: "gray"
            height: 1

            Layout.row: 1
            Layout.rowSpan: 1
            Layout.column: 0
            Layout.columnSpan: 4
            Layout.fillWidth : true
            Layout.preferredWidth: parent.width
            Layout.alignment:  Qt.AlignTop | Qt.AlignHCenter
            Layout.margins: 0
        }

        Rectangle{
            id: seperator2
            color: "gray"
            height: 1

            Layout.row: 3
            Layout.rowSpan: 1
            Layout.column: 0
            Layout.columnSpan: 4
            Layout.fillWidth : true
            Layout.preferredWidth: parent.width
            Layout.alignment:  Qt.AlignTop | Qt.AlignHCenter
            Layout.margins: 0
        }

        Rectangle{
            id: whiteIcon
            width: Style.controlFontSize
            height:Style.controlFontSize
            radius: height/2
            color: "white"
            border.color: "gray"
            border.width: 2

            Layout.row: 0
            Layout.rowSpan: 1
            Layout.column: 0
            Layout.columnSpan: 1
            Layout.alignment:  Qt.AlignTop
            Layout.margins: 0
        }

        Rectangle{
            id: redIcon
            width: Style.controlFontSize
            height:Style.controlFontSize
            radius: height/2
            color: "red"
            border.color: "gray"
            border.width: 2

            Layout.row: 2
            Layout.rowSpan: 1
            Layout.column: 0
            Layout.columnSpan: 1
            Layout.alignment:  Qt.AlignTop
            Layout.margins: 0
        }

        Rectangle{
            id: blueIcon
            width: Style.controlFontSize
            height:Style.controlFontSize
            radius: height/2
            color: "#1E90FF"
            border.color: "gray"
            border.width: 2

            Layout.row: 4
            Layout.rowSpan: 1
            Layout.column: 0
            Layout.columnSpan: 1
            Layout.alignment:  Qt.AlignTop
            Layout.margins: 0
        }

        Text{
            id: whiteText
            text: qsTr("weiss")
            color: Style.textColor

            Layout.row: 0
            Layout.rowSpan: 1
            Layout.column: 1
            Layout.columnSpan: 1
            Layout.fillHeight: true
            Layout.fillWidth : true
            Layout.alignment:  Qt.AlignLeft
            Layout.margins: 0
        }

        Text{
            id: redText
            text: qsTr("red")
            color: Style.textColor

            Layout.row: 2
            Layout.rowSpan: 1
            Layout.column: 1
            Layout.columnSpan: 1
            Layout.fillHeight: true
            Layout.fillWidth : true
            Layout.alignment:  Qt.AlignLeft
            Layout.margins: 0
        }

        Text{
            id: blueText
            text: qsTr("blue")
            color: Style.textColor

            Layout.row: 4
            Layout.rowSpan: 1
            Layout.column: 1
            Layout.columnSpan: 1
            Layout.fillHeight: true
            Layout.fillWidth : true
            Layout.alignment:  Qt.AlignLeft
            Layout.margins: 0
        }

        Text{
            id: whiteNoOfPiecesText
            text: qsTr("%1 Stk.").arg(countingLogic.whiteStoneCounter)
            color: Style.textColor

            Layout.row: 0
            Layout.rowSpan: 1
            Layout.column: 2
            Layout.columnSpan: 1
            Layout.fillHeight: true
            Layout.fillWidth : true
            Layout.alignment:  Qt.AlignLeft
            Layout.margins: 0
        }

        Text{
            id: redNoOfPiecesText
            text: qsTr("%1 Stk.").arg(countingLogic.redStoneCounter)
            color: Style.textColor

            Layout.row: 2
            Layout.rowSpan: 1
            Layout.column: 2
            Layout.columnSpan: 1
            Layout.fillHeight: true
            Layout.fillWidth : true
            Layout.alignment:  Qt.AlignLeft
            Layout.margins: 0
        }

        Text{
            id: blueNoOfPiecesText
            text: qsTr("%1 Stk.").arg(countingLogic.blueStoneCounter)
            color: Style.textColor

            Layout.row: 4
            Layout.rowSpan: 1
            Layout.column: 2
            Layout.columnSpan: 1
            Layout.fillHeight: true
            Layout.fillWidth : true
            Layout.alignment:  Qt.AlignLeft
            Layout.margins: 0
        }

        Text{
            id: whiteSpeedText
            text: qsTr("\u00D8 %1 s").arg(3.8)
            color: Style.textColor

            Layout.row: 0
            Layout.rowSpan: 1
            Layout.column: 3
            Layout.columnSpan: 1
            Layout.fillHeight: true
            Layout.fillWidth : true
            Layout.alignment:  Qt.AlignLeft
            Layout.margins: 0
        }

        Text{
            id: redSpeedText
            text: qsTr("\u00D8 %1 s").arg(4.3)
            color: Style.textColor

            Layout.row: 2
            Layout.rowSpan: 1
            Layout.column: 3
            Layout.columnSpan: 1
            Layout.fillHeight: true
            Layout.fillWidth : true
            Layout.alignment:  Qt.AlignLeft
            Layout.margins: 0
        }

        Text{
            id: blueSpeedText
            text: qsTr("\u00D8 %1 s").arg(4.7)
            color: Style.textColor

            Layout.row: 4
            Layout.rowSpan: 1
            Layout.column: 3
            Layout.columnSpan: 1
            Layout.fillHeight: true
            Layout.fillWidth : true
            Layout.alignment:  Qt.AlignLeft
            Layout.margins: 0
        }

        Item {
            id: spacerItem

            Layout.row: 5
            Layout.rowSpan: 1
            Layout.column: 0
            Layout.columnSpan: 4
            Layout.fillHeight: true
            Layout.fillWidth : true
            Layout.alignment:  Qt.AlignLeft
            Layout.margins: 0
            Layout.preferredHeight: parent.height/5
        }
    }
}

