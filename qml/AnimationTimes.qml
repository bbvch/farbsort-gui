import QtQuick 2.0
pragma Singleton

QtObject {
    // all times in ms
    readonly property int timeFromSensorOneToSensorTwo: 3100
    readonly property int timeFromSensorTwoToEjectorOne: 500
    readonly property int timeFromSensorTwoToEjectorTwo: 1400
    readonly property int timeFromSensorTwoToEjectorThree: 2300
    readonly property int timeFromSensorTwoToUndefinedBin: timeFromSensorTwoToEjectorThree * 1.375
    readonly property int timeFromEjectorToBin: 200
    readonly property var timesFromSensorTwoToEndOnConveyor: [timeFromSensorTwoToUndefinedBin, timeFromSensorTwoToEjectorOne, timeFromSensorTwoToEjectorTwo, timeFromSensorTwoToEjectorThree]
}
