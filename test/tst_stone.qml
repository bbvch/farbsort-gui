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
        stone.state = "DETECTING"

        verify(stone.handleColorDetected(red, trayId, destinationXPos), "handleColorDetected signal is handled")
        compare(stone.state, "DETECTING", "state is still DETECTING")
        compare(stone.color, red, "color changed to red")
        compare(stone.trayId, trayId, "tray id is set to " + trayId)
        compare(stone.destinationXPos, destinationXPos, "stone is moved to destinationXPos " + destinationXPos)
    }

    function test_stone_is_move_to_tray_one_when_color_blue_is_detected()
    {
        stone.state = "DETECTING"
        stone.color = "#0000ff"
        stone.trayId = 1
        stone.destinationXPos = 222

        verify(stone.handleDetectorEndReached(), "handled detectorEndReached event")
        compare(stone.state, "MOVING", "state changed to MOVING")
    }

    function test_stone_is_ejected_after_ejecting_event_is_handled()
    {
        var trayId = 1
        stone.state = "MOVING"
        stone.trayId = trayId

        verify(stone.handleStartEjecting(trayId), "startEjecting event handled for tray " + trayId)
        compare(stone.state, "EJECTING", "state change to EJECTING")
    }

    function test_stone_has_reached_bin_after_reached_event_is_handled()
    {
        var trayId = 1
        stone.state = "EJECTING"
        stone.trayId = trayId

        verify(stone.handleTrayReached(trayId), "trayReached event handled for tray " + trayId)
        compare(stone.state, "REACHED", "state change to REACHED")
    }
}

