import QtQuick 2.3
import QtTest 1.0

import "qrc:/components"

TestCase {
    id: stoneTest
    name: "StoneTest"

    function get_stone()
    {
        var component = Qt.createComponent("qrc:/components/Stone.qml")
        return component.createObject(stoneTest)
    }

    function test_stone_is_correclty_initialized_after_creation()
    {
        var stone = get_stone()
        compare(stone.trayId, 0, "tray is initialized to zero")
        compare(stone.color, "#00000000", "initial color is transparent")
        compare(stone.state, "created", "initial state is created")
    }
}

