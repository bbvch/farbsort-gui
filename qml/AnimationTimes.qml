import QtQuick 2.0
pragma Singleton

QtObject {
    // all times in ms
    readonly property int timeFromSensorOneToSensorTwo: 706
    readonly property int timeFromSensorTwoToEjectorOne: 690
    readonly property int timeFromSensorTwoToEjectorTwo: 1720
    readonly property int timeFromSensorTwoToEjectorThree: 2640
    readonly property int timeFromSensorTwoToUndefinedBin: timeFromSensorTwoToEjectorThree * 1.375
    readonly property int timeFromEjectorToBin: 300
    readonly property var timesFromSensorTwoToEndOnConveyor: [timeFromSensorTwoToUndefinedBin, timeFromSensorTwoToEjectorOne, timeFromSensorTwoToEjectorTwo, timeFromSensorTwoToEjectorThree]
}
