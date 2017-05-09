#ifndef WEBSOCKETCLIENTSIMULATION_H
#define WEBSOCKETCLIENTSIMULATION_H

#include "websocketclient.h"

class WebSocketClientSimulation : public WebSocketClient
{
    Q_OBJECT
public:
    WebSocketClientSimulation();

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

    /** slot to set the state of an lightbarrier */
    void lightbarrierActivated(int number, bool state);
    /** slot to set the detected color */
    void sendDetectedColor(const QColor& color);
};

#endif // WEBSOCKETCLIENTSIMULATION_H
