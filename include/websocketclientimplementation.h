#ifndef WEBSOCKETCLIENTIMPLEMENTATION_H
#define WEBSOCKETCLIENTIMPLEMENTATION_H

#include "websocketclient.h"

#include <QtWebSockets/QWebSocket>

class WebSocketClientImplementation : public WebSocketClient
{
    Q_OBJECT
public:
    explicit WebSocketClientImplementation(const QString ipAddress);
    ~WebSocketClientImplementation();

public slots:
    /** slot to reconnect to websocket service */
    void reconnectService();

public slots:
    /** slot to set the motor to switch on/off */
    void sendMotorRunningRequest(const bool motorRunning) override;
    /** slot to set the compressor to switch on/off */
    void sendCompressorRunningRequest(const bool compressorRunning) override;
    /** sends a eject valve request with the given number */
    void sendValveStateRequest(int number, const bool active) override;
    void sendAllValveStateRequest(const bool active) override;
    void sendProductionModeRequest(const bool active) override;
    void sendProductionStart(const bool active) override;
    void sendEmergencyStop() override;

private Q_SLOTS:
    void onConnected();
    void onDisconnected();
    void onTextMessageReceived(QString message);

private:
    QWebSocket m_webSocket;
    const QUrl m_url;
    bool m_wasConnectedBefore = true;
};

#endif // WEBSOCKETCLIENTIMPLEMENTATION_H
