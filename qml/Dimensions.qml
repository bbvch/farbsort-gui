import QtQuick 2.0
pragma Singleton

QtObject {
    // fixed dimensions according to fischer technics model in cm
    readonly property double stoneWidth: 2.5

    readonly property double conveyorWidth: 40.0
    readonly property double conveyorHeight: 3.0

    readonly property double undefinedBinWidth: conveyorHeight
    readonly property double undefinedBinHeight: conveyorHeight

    readonly property double lightbarrierOneTwoWidth: 1
    readonly property double lightbarrierOneTwoHeight: conveyorHeight + 2 * lightbarrierOneTwoWidth

    readonly property double colorDetectorHorizontalCenter: 11.0
    readonly property double colorDetectorWidth: 11.0
    readonly property double colorDetectorHeight: 6.0

    readonly property double sensorOneHorizontalCenter: 3.0
    readonly property double sensorTwoHorizontalCenter: 21.5

    readonly property double ejectorOneHorizontalCenter: 24.0
    readonly property double ejectorTwoHorizontalCenter: 29.5
    readonly property double ejectorThreeHorizontalCenter: 35.7
    readonly property double ejectorHeight: 9.0
    readonly property double ejectorWidth: 3.0
    readonly property double slideHeight: 7.0
    readonly property double slideWidth: 3.0

    readonly property double simulatorHeight: conveyorHeight + ejectorHeight + slideHeight
    readonly property double simulatorWidth: conveyorWidth + undefinedBinWidth


    // calculated factors based on space used for simulator item
    readonly property double stoneWidthFactor: stoneWidth / simulatorWidth
    readonly property double conveyorHeightFactor: conveyorHeight / simulatorHeight
    readonly property double conveyorWidthFactor: conveyorWidth / simulatorWidth
    readonly property double conveyorVerticalCenterFactor: (ejectorHeight + (conveyorHeight / 2)) / simulatorHeight

    readonly property double undefinedBinHeightFactor: undefinedBinHeight / simulatorHeight
    readonly property double undefinedBinWidthFactor: undefinedBinWidth / simulatorWidth

    readonly property double lightbarrierOneTwoHeightFactor: lightbarrierOneTwoHeight / simulatorHeight
    readonly property double lightbarrierOneTwoWidthFactor: lightbarrierOneTwoWidth / simulatorWidth

    readonly property double colorDetectorHorizontalCenterFactor: colorDetectorHorizontalCenter / simulatorWidth
    readonly property double colorDetectorHeightFactor: colorDetectorHeight / simulatorHeight
    readonly property double colorDetectorWidthFactor: colorDetectorWidth / simulatorWidth

    readonly property double sensorOneHorizontalCenterFactor: sensorOneHorizontalCenter / simulatorWidth
    readonly property double sensorTwoHorizontalCenterFactor: sensorTwoHorizontalCenter / simulatorWidth
    readonly property double sensorVerticalCenterFactor: (ejectorHeight + (conveyorHeight / 2)) / simulatorHeight

    readonly property double ejectorOneHorizontalCenterFactor: ejectorOneHorizontalCenter / simulatorWidth
    readonly property double ejectorTwoHorizontalCenterFactor: ejectorTwoHorizontalCenter / simulatorWidth
    readonly property double ejectorThreeHorizontalCenterFactor: ejectorThreeHorizontalCenter / simulatorWidth
    readonly property double ejectorHeightFactor: ejectorHeight / simulatorHeight
    readonly property double ejectorWidthFactor: ejectorWidth / simulatorWidth
    readonly property double slideHeightFactor: slideHeight / simulatorHeight
    readonly property double slideWidthFactor: slideWidth / simulatorWidth
}
