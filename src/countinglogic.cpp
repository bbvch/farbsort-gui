#include "countinglogic.h"

#include <QDebug>

CountingLogic::CountingLogic()
  : QObject(nullptr)
  , m_trayOneColor(Qt::blue)
  , m_trayTwoColor(Qt::red)
  , m_trayThreeColor(Qt::white)
{
    m_stoneCounters.push_back(QSharedPointer<StoneCounter>(new StoneCounter()));
    m_stoneCounters.push_back(QSharedPointer<StoneCounter>(new StoneCounter()));
    m_stoneCounters.push_back(QSharedPointer<StoneCounter>(new StoneCounter()));
}

StoneCounter* CountingLogic::trayOneStoneCounter()
{
    return m_stoneCounters[0].data();
}

StoneCounter* CountingLogic::trayTwoStoneCounter()
{
    return m_stoneCounters[1].data();
}

StoneCounter* CountingLogic::trayThreeStoneCounter()
{
    return m_stoneCounters[2].data();
}

void CountingLogic::stoneReachedInTray(const int trayId, const int timeNeeded)
{
    if(trayId > 0 && trayId <= m_stoneCounters.count()) {
        m_stoneCounters[trayId - 1]->addStone(timeNeeded);
    }
}

void CountingLogic::setTrayOneColor(const QColor color)
{
    if(color != m_trayOneColor) {
        m_trayOneColor = color;
        emit trayOneColorChanged();
    }
}

void CountingLogic::setTrayTwoColor(const QColor color)
{
    if(color != m_trayTwoColor) {
        m_trayTwoColor = color;
        emit trayTwoColorChanged();
    }
}

void CountingLogic::setTrayThreeColor(const QColor color)
{
    if(color != m_trayThreeColor) {
        m_trayThreeColor = color;
        emit trayThreeColorChanged();
    }
}
