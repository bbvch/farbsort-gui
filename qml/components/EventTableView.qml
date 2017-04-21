import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

import ".."

Item {
     id: eventTableView
     property alias model: tableView.model

     TableView{
         id:tableView
         anchors.fill: parent
         selectionMode: SelectionMode.NoSelection

         style: TableViewStyle {
                 frame: Rectangle {
                            border.width: 0
                        }
             }

         headerDelegate:Rectangle{
            color: "transparent"
            height:0
         }

         TableViewColumn {
             id: markColumn
             role: "icon"
             movable: false
             resizable: false
             width: tableView.viewport.width/12 // - dateColumn.width - msgColumn.width

             delegate: Item {
                         height: 24
                         width: 24
                         Image {
                             //mipmap: true
                             source: styleData.value
                             height: 24
                             width: 24
                             anchors.centerIn: parent
                         }
                     }
         }

         TableViewColumn {
             id: dateColumn
             role: "date"
             movable: false
             resizable: false
             width: tableView.viewport.width*4/12
         }

         TableViewColumn {
             id: noColumn
             role: "no"
             movable: false
             resizable: false
             width: tableView.viewport.width / 12

         }

         TableViewColumn {
             id: colorColumn
             role: "color"
             movable: false
             resizable: true
             width: tableView.viewport.width / 24

             delegate:   Item{
                 Rectangle{
                     id: colorIcon
                     width:  Style.controlFontSize
                     height: width

                     radius: height/2
                     color: styleData.value
                     border.color: "gray"
                     border.width: 2
                     visible: styleData.value !== "transparent"
                     anchors.centerIn: parent
                 }
             }
         }

         TableViewColumn {
             id: msgColumn
             role: "message"
             movable: false
             resizable: false
             width: tableView.viewport.width / 2
         }

         model: logList

             /*ListModel {
               ListElement {
                   icon: "qrc:/checkmark.png"
                   date: "20.10.2016, 13:37"
                   no:   "1"
                   color: "red"
                   message:"Fördermenge angekommen"
               }
               ListElement {
                   icon: "qrc:/warning.png"
                   date: "18.10.2016, 08:46"
                   no:   ""
                   color: "transparent"
                   message:"Störung Ausstosser A2"
               }
               ListElement {
                   icon: "qrc:/checkmark.png"
                   date: "18.10.2016, 09:33"
                   no:   "1"
                   color: "blue"
                   message:"Fördermenge angekommen"
               }
               ListElement {
                   icon: "qrc:/checkmark.png"
                   date: "18.10.2016, 09:53"
                   no:   "1"
                   color: "white"
                   message:"Fördermenge angekommen"
               }
           }*/

         rowDelegate: Rectangle{
             width: childrenRect.width
             height: tableView.height/4
             Rectangle{
                  anchors.bottom: parent.bottom
                  height: 1
                  color: "lightgray"
                  width: childrenRect.width
              }
         }
     }
}
