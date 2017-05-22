import QtQuick 2.3
import QtTest 1.0

import "qrc:/components"

TestCase {
    id: stoneTest
    name: "StoneTest"

    property Stone stone: null

    function init()
    {
        var component = Qt.createComponent("qrc:/components/Stone.qml")
        stone =  component.createObject(stoneTest)
    }

    function cleanup()
    {
        stone.destroy()
    }

    function test_stone_is_correclty_initialized_after_creation()
    {
        compare(stone.trayId, 0, "tray is initialized to zero")
        compare(stone.color, "#00000000", "initial color is transparent")
        compare(stone.state, "CREATED", "initial state is CREATED")
    }

    function test_stone_in_detecting_state_after_it_was_placed_on_conveyor()
    {
        stone.handleDetectionStarted()
        compare(stone.state, "DETECTING", "state changed to DETECTING")
    }

    function test_stone_changes_color_after_color_detected_event_was_handled()
    {
        var trayId = 1
        var color = "#ff0000" //red

        stone.trayId = trayId
        stone.handleDetectionStarted()
        verify(stone.handleColorDetected(color, trayId, 111), "handleColorDetected signal is handled")
        compare(stone.state, "DETECTING", "state is still DETECTING")
        compare(stone.color, color, "color changed to red")
    }
}

