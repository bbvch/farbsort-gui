#include "websocketclientimplementation.h"

#include <QtCore/QDebug>
#include <QTimer>

WebSocketClientImplementation::WebSocketClientImplementation(const QString ipAddress)
    : m_url(QUrl("ws://" + ipAddress + ":8888/ws"))
{
    qDebug() << "wsc: WebSocketClient created:" << m_url;
    connect(&m_webSocket, &QWebSocket::connected, this, &WebSocketClientImplementation::onConnected);
    connect(&m_webSocket, &QWebSocket::disconnected, this, &WebSocketClientImplementation::onDisconnected);

    // Was in onConnected() slot before, but should probably be here, as there exist multiple connections, if this
    // signal/slot is connected on every new (re-)connect => comment left for possible troubleshooting
    connect(&m_webSocket, &QWebSocket::textMessageReceived, this, &WebSocketClientImplementation::onTextMessageReceived);
    m_webSocket.open(m_url);
}

WebSocketClientImplementation::~WebSocketClientImplementation()
{
    m_webSocket.close();
}

void WebSocketClientImplementation::sendMotorRunningRequest(const bool motorRunning)
{
    if(motorRunning != m_motorRunning) {
        if(motorRunning) {
            m_webSocket.sendTextMessage("motor=start");
        } else {
            m_webSocket.sendTextMessage("motor=stop");
        }
    }
}

void WebSocketClientImplementation::sendCompressorRunningRequest(const bool compressorRunning)
{
    if(compressorRunning != m_compressorRunning) {
        if(compressorRunning) {
            m_webSocket.sendTextMessage("compressor=start");
        } else {
            m_webSocket.sendTextMessage("compressor=stop");
        }
    }
}

void WebSocketClientImplementation::sendValveStateRequest(int number, const bool active)
{
    if(1 <= number && 3 >= number) {
        QString msg;

        if(active)
            msg = "valve" + QString::number(number) + "=on";
        else
            msg = "valve" + QString::number(number) + "=off";

        m_webSocket.sendTextMessage(msg);
    }
}

void WebSocketClientImplementation::sendAllValveStateRequest(const bool active)
{
    for(int i=1; i<=3; ++i)
    {
        sendValveStateRequest(i, active);
    }
}

void WebSocketClientImplementation::sendProductionModeRequest(const bool active)
{
    if(active)
    {
        sendAllValveStateRequest(false);
        sendCompressorRunningRequest(false);
        sendMotorRunningRequest(false);

        m_webSocket.sendTextMessage("mode=normal");
    }
    else
    {
        sendProductionStart(false);
        m_webSocket.sendTextMessage("mode=diagnostic");
    }
}

void WebSocketClientImplementation::sendProductionStart(const bool active)
{
    if(active)
    {
        m_webSocket.sendTextMessage("start");
        emit logMessageToBeDisplayed("Start production",LogEntry::LogLevel::Info);
    }
    else
    {
        m_webSocket.sendTextMessage("stop");
        emit logMessageToBeDisplayed("Stop production",LogEntry::LogLevel::Info);
    }
}

void WebSocketClientImplementation::sendEmergencyStop()
{
    m_webSocket.sendTextMessage("stop");
    emit logMessageToBeDisplayed("Emergency stop!",LogEntry::LogLevel::Warning);
}

void WebSocketClientImplementation::reconnectService()
{
    qDebug() << "wsc: reconnect to service";

    // Emit logMessage from here, as this this does not conflict with startup
    if(m_wasConnectedBefore && (QAbstractSocket::UnconnectedState == m_webSocket.state()))
    {
        emit logMessageToBeDisplayed("Websocket disconnected!",LogEntry::LogLevel::Error);
        m_wasConnectedBefore = false;
    }
    m_webSocket.open(m_url);
}

void WebSocketClientImplementation::onConnected()
{
    qDebug() << "wsc: WebSocket connected";
    m_connected = true;
    m_wasConnectedBefore = true;
    emit connectedChanged();
    emit logMessageToBeDisplayed("Websocket connected",LogEntry::LogLevel::Info);
}

void WebSocketClientImplementation::onDisconnected()
{
    qDebug() << "wsc: WebSocket disconnected";
    m_connected = false;
    emit connectedChanged();
    setMotorRunning(false);
    setCompressorRunning(false);
    for(int number = 1; number <= 5; number++) {
        setLightbarrierState(number, false);
    }
    QTimer::singleShot(500, this, SLOT(reconnectService()));
}

void WebSocketClientImplementation::onTextMessageReceived(QString message)
{
    qDebug() << "wsc: received message: " << message;

    // received message mode=...
    if(message.startsWith("mode=")) {}

    // received message sort-order=...
    else if(message.startsWith("sort-order=")) {}

    // received message controller=...
    else if(message.startsWith("controller=")) {}

    // received message motor=...
    else if(message.startsWith("motor=")) {}

    // received message conveyor=...
    else if(message.startsWith("conveyor=")) {
        setMotorRunning(message.endsWith("running"));
        if(message.endsWith("running"))
            emit logMessageToBeDisplayed("Started conveyor",LogEntry::LogLevel::Info);
        else
            emit logMessageToBeDisplayed("Stopped conveyor",LogEntry::LogLevel::Info);
    }

    // received message compressor=...
    else if(message.startsWith("compressor=")) {
        setCompressorRunning(message.endsWith("start"));
        if(message.endsWith("start"))
            emit logMessageToBeDisplayed("Started compressor",LogEntry::LogLevel::Info);
        else
            emit logMessageToBeDisplayed("Stopped compressor",LogEntry::LogLevel::Info);
    }

    // received message emergency-stop=...
    else if(message.startsWith("emergency-stop=")) {
        emit logMessageToBeDisplayed("Emergency stop!",LogEntry::LogLevel::Warning);
    }

    // received message lightbarier<N>=...
    else if(message.startsWith("lightbarrier")) {
        const bool lightbarrierState = message.endsWith("on");
        QStringRef lightbarrierNumber(&message, 12, 1);
        setLightbarrierState(lightbarrierNumber.toInt(), lightbarrierState);
    }

    // received message valve<N>=...
    else if(message.startsWith("valve")) {
        const bool valveState = message.endsWith("on");
        QStringRef valveNumber(&message, 5, 1);
        setValveState(valveNumber.toInt(), valveState);
    }

    // received message color=...
    else if(message.startsWith("color=")) {
        QColor color = QColor(message.right(message.length() - 6));
        setDetectedColor(color);
    }

    // received log message
    else if(message.startsWith("log:")) {
        if(message.contains("Warning:", Qt::CaseInsensitive))
            emit logMessageToBeDisplayed(message.section(':', 2), LogEntry::LogLevel::Warning);
        else if(message.contains("Error:", Qt::CaseInsensitive))
            emit logMessageToBeDisplayed(message.section(':', 2), LogEntry::LogLevel::Error);
        else
            emit logMessageToBeDisplayed(message.section(':', 1), LogEntry::LogLevel::Info);
    }

    // unknown message
    else {
        qWarning() << "wsc: message '" << message << "' was not handled";
    }
}

