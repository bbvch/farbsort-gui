#ifndef WEBSOCKETCLIENT_H
#define WEBSOCKETCLIENT_H

#include <QtCore/QObject>
#include <QColor>
#include <QtQml>
#include "EventLog.h"

class WebSocketClient : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool connected READ connected NOTIFY connectedChanged)
    Q_PROPERTY(bool motorRunning READ motorRunning WRITE setMotorRunning NOTIFY motorRunningChanged)
    Q_PROPERTY(bool compressorRunning READ compressorRunning WRITE setCompressorRunning NOTIFY compressorRunningChanged)
    Q_PROPERTY(bool lightbarrierOneState READ lightbarrierOneState NOTIFY lightbarrierOneStateChanged)
    Q_PROPERTY(bool lightbarrierTwoState READ lightbarrierTwoState NOTIFY lightbarrierTwoStateChanged)
    Q_PROPERTY(bool lightbarrierThreeState READ lightbarrierThreeState NOTIFY lightbarrierThreeStateChanged)
    Q_PROPERTY(bool lightbarrierFourState READ lightbarrierFourState NOTIFY lightbarrierFourStateChanged)
    Q_PROPERTY(bool lightbarrierFiveState READ lightbarrierFiveState NOTIFY lightbarrierFiveStateChanged)
    Q_PROPERTY(bool valve1State READ valve1State NOTIFY valve1StateChanged)
    Q_PROPERTY(bool valve2State READ valve2State NOTIFY valve2StateChanged)
    Q_PROPERTY(bool valve3State READ valve3State NOTIFY valve3StateChanged)

Q_SIGNALS:
    void connectedChanged();
    void motorRunningChanged();
    void compressorRunningChanged();
    void lightbarrierOneStateChanged();
    void lightbarrierTwoStateChanged();
    void lightbarrierThreeStateChanged(const bool active);
    void lightbarrierFourStateChanged(const bool active);
    void lightbarrierFiveStateChanged(const bool active);
    void colorDetected(const QColor& color);
    void valve1StateChanged();
    void valve2StateChanged();
    void valve3StateChanged();
    void logMessageToBeDisplayed(const QString message, const LogEntry::LogLevel logLevel = LogEntry::LogLevel::Info, const QString no = "", const QColor color = Qt::transparent);

public:
    WebSocketClient();

public slots:
    /** slot to set the motor to switch on/off */
    virtual void sendMotorRunningRequest(const bool motorRunning) = 0;
    /** slot to set the compressor to switch on/off */
    virtual void sendCompressorRunningRequest(const bool compressorRunning) = 0;
    /** sends a eject valve request with the given number */
    virtual void sendValveStateRequest(int number, const bool active) = 0;
    virtual void sendAllValveStateRequest(const bool active) = 0;
    virtual void sendProductionModeRequest(const bool active)=0;
    virtual void sendProductionStart(const bool active)=0;
    virtual void sendEmergencyStop()=0;

protected:
    /** getters */
    bool connected() const { return m_connected; }
    bool motorRunning() const { return m_motorRunning; }
    bool compressorRunning() const { return m_compressorRunning; }
    bool lightbarrierOneState() const { return m_lightbarrierOneState; }
    bool lightbarrierTwoState() const { return m_lightbarrierTwoState; }
    bool lightbarrierThreeState() const { return m_lightbarrierThreeState; }
    bool lightbarrierFourState() const { return m_lightbarrierFourState; }
    bool lightbarrierFiveState() const { return m_lightbarrierFiveState; }
    bool valve1State() const { return m_valve1State; }
    bool valve2State() const { return m_valve2State; }
    bool valve3State() const { return m_valve3State; }
    /** setters */
    void setMotorRunning(const bool motorRunning);
    void setCompressorRunning(const bool compressorRunning);
    /** sets the state for the given light barrier */
    void setLightbarrierState(const int number, const bool state);
    /** sets the internal valve state */
    void setValveState(const int valveId, const bool state);

protected:
    bool m_connected;
    bool m_motorRunning;
    bool m_compressorRunning;
    bool m_lightbarrierOneState;
    bool m_lightbarrierTwoState;
    bool m_lightbarrierThreeState;
    bool m_lightbarrierFourState;
    bool m_lightbarrierFiveState;
    bool m_valve1State;
    bool m_valve2State;
    bool m_valve3State;
};

#endif // WEBSOCKETCLIENT_H
