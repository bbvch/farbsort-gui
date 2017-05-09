#include "websocketclientsimulation.h"

#include <QtCore/QTimer>
#include <QtCore/QDebug>

const int LIGHTBARRIER_ACTIVATION_TIMEOUT = 200;

WebSocketClientSimulation::WebSocketClientSimulation()
{
    m_connected = true;
}

void WebSocketClientSimulation::sendMotorRunningRequest(const bool motorRunning)
{
    setMotorRunning(motorRunning);
}

void WebSocketClientSimulation::sendCompressorRunningRequest(const bool compressorRunning)
{
    setCompressorRunning(compressorRunning);
}

void WebSocketClientSimulation::sendValveStateRequest(int number, const bool active)
{
    setValveState(number, active);
}

void WebSocketClientSimulation::sendAllValveStateRequest(const bool active)
{
    for(int i=1; i<=3; ++i)
    {
        sendValveStateRequest(i, active);
    }
}

void WebSocketClientSimulation::sendProductionModeRequest(const bool active)
{
    Q_UNUSED(active)
    //TODO: Add code for mode switching normal/diagnostic
}

void WebSocketClientSimulation::sendProductionStart(const bool active)
{
    Q_UNUSED(active)
    //TODO: Add code for starting production
}

void WebSocketClientSimulation::sendEmergencyStop()
{
    //TODO: Add code for emergency stop in simulation mode
}

void WebSocketClientSimulation::lightbarrierActivated(int number, bool state)
{
    setLightbarrierState(number, state);
}

void WebSocketClientSimulation::sendDetectedColor(const QColor& color)
{
    emit colorDetected(color);
}
