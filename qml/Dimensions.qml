import QtQuick 2.0
pragma Singleton

QtObject {
    // fixed dimensions according to fischer technics model in cm
    readonly property double conveyorLength: 40.0
    readonly property double conveyorHeight: 2.0

    readonly property double undefinedBinLength: conveyorHeight
    readonly property double undefinedBinHeight: conveyorHeight

    readonly property double posXColorDetector: 11.0

    readonly property double posXSensorOne: 3.0
    readonly property double posXSensorTwo: 21.5

    readonly property double posXEjectorOne: 24.0
    readonly property double posXEjectorTwo: 29.5
    readonly property double posXEjectorThree: 35.7
    readonly property double ejectorHeight: 3.0
    readonly property double ejectorWidth: 3.0 // todo: measure model
    readonly property double slideHeight: 7.0
    readonly property double slideWidth: 6.0 // todo: measure model

    readonly property double simulatorHeight: conveyorHeight + ejectorHeight + slideHeight
    readonly property double simulatorLength: conveyorLength + undefinedBinLength

    // calculated factors based on space used for simulator item

    readonly property double conveyorHeightFactor: conveyorHeight / simulatorHeight
    readonly property double conveyorWidthFactor: conveyorLength / simulatorLength
    readonly property double conveyorVerticalCenterFactor: (ejectorHeight + (conveyorHeight / 2)) / simulatorHeight

    readonly property double undefinedBinHeightFactor: undefinedBinHeight / simulatorHeight
    readonly property double undefinedBinWidthFactor: undefinedBinLength / simulatorLength

    readonly property double colorDetectorHoricontalCenterFactor: posXColorDetector / simulatorLength
    readonly property double colorDetectorHeightFactor: conveyorHeightFactor * 1.5

    readonly property double posXSensorOneFactor: posXSensorOne / simulatorLength
    readonly property double posXSensorTwoFactor: posXSensorTwo / simulatorLength
    readonly property double posYSensorFactor: (ejectorHeight + (conveyorHeight / 2)) / simulatorHeight

    readonly property double ejectorOneHoricontalCenterFactor: posXEjectorOne / simulatorLength
    readonly property double ejectorTwoHoricontalCenterFactor: posXEjectorTwo / simulatorLength
    readonly property double ejectorThreeHoricontalCenterFactor: posXEjectorThree / simulatorLength
    readonly property double ejectorHeightFactor: ejectorHeight / simulatorHeight
    readonly property double ejectorWidthFactor: ejectorWidth / simulatorLength
    readonly property double slideHeightFactor: slideHeight / simulatorHeight
    readonly property double slideWidthFactor: slideWidth / simulatorLength
}
