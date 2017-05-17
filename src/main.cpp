#include <QCommandLineParser>
#include <QDebug>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQmlEngine>
#include <QResource>
#include <QSharedPointer>
#include <QVariant>

#include "websocketclientimplementation.h"
#include "websocketclientsimulation.h"
#include "countinglogic.h"
#include "EventLog.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QCoreApplication::setApplicationName("farbsort");
    QCoreApplication::setApplicationVersion(APP_VERSION);

    // parse arguments
    QCommandLineParser parser;
    parser.setApplicationDescription("Farbsort helper");
    parser.addHelpOption();
    parser.addVersionOption();
    QCommandLineOption ipAddressOption(QStringList() << "ip-address", QCoreApplication::translate("main", "ip address to connect to websocket service"), "ip-address");
    ipAddressOption.setDefaultValue("127.0.0.1");
    parser.addOption(ipAddressOption);
    QCommandLineOption simulationOption(QStringList() << "simulation", QCoreApplication::translate("main", "sets the webclient socket into simulation mode"));
    parser.addOption(simulationOption);
    parser.process(app);

    qDebug() << "CommandLineOption::ipAddress: " << parser.value("ip-address");

    qmlRegisterType<WebSocketClient>();

    QSharedPointer<WebSocketClient> webSocketClient;
    if(parser.isSet("simulation")) {
        webSocketClient.reset(new WebSocketClientSimulation());
    } else {
        webSocketClient.reset(new WebSocketClientImplementation(QString(parser.value("ip-address"))));
    }

//    qmlRegisterType<WebSocketClient>("com.mycompany.qmlcomponents", 1, 0, "Slider");

    CountingLogic countingLogic;
    QObject::connect(webSocketClient.data(), SIGNAL(lightbarrierThreeStateChanged(bool)), &countingLogic, SLOT(trayOneLightbarrierActivationChanged(bool)));
    QObject::connect(webSocketClient.data(), SIGNAL(lightbarrierFourStateChanged(bool)), &countingLogic, SLOT(trayTwoLightbarrierActivationChanged(bool)));
    QObject::connect(webSocketClient.data(), SIGNAL(lightbarrierFiveStateChanged(bool)), &countingLogic, SLOT(trayThreeLightbarrierActivationChanged(bool)));

    EventLog eventLog;
    QObject::connect(webSocketClient.data(), SIGNAL(logMessageToBeDisplayed(QString,LogEntry::LogLevel,QString,QColor)), &eventLog, SLOT(addLogEntry(QString,LogEntry::LogLevel,QString,QColor)));

    // start application
    QResource::registerResource("qml.qrc");
    QResource::registerResource("images.qrc");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("websocketClient", webSocketClient.data());
    engine.rootContext()->setContextProperty("simulationModeActive", QVariant(parser.isSet("simulation")));
    engine.rootContext()->setContextProperty("countingLogic", &countingLogic);
    engine.rootContext()->setContextProperty("logList", &eventLog);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
