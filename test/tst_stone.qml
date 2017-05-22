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
        var red = "#ff0000"
        var destinationXPos = 111

        stone.trayId = trayId
        stone.handleDetectionStarted()
        verify(stone.handleColorDetected(red, trayId, destinationXPos), "handleColorDetected signal is handled")
        compare(stone.state, "DETECTING", "state is still DETECTING")
        compare(stone.color, red, "color changed to red")
        compare(stone.destinationXPos, destinationXPos, "stone is moved to destinationXPos " + destinationXPos)
    }

    function test_stone_is_move_to_tray_one_when_color_blue_is_detected()
    {
        var trayId = 1
        var blue = "#0000ff"
        var destinationXPos = 222

        stone.handleDetectionStarted()
        stone.handleColorDetected(blue, trayId, destinationXPos)
        verify(stone.handleDetectorEndReached(), "handled detectorEndReached event")
        compare(stone.state, "MOVING", "state changed to MOVING")
    }
}

