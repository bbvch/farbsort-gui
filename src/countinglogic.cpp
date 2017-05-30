#include "countinglogic.h"

#include <QDebug>

CountingLogic::CountingLogic()
  : QObject(nullptr)
{
    m_stoneCounters.push_back(QSharedPointer<StoneCounter>(new StoneCounter(Qt::blue)));
    m_stoneCounters.push_back(QSharedPointer<StoneCounter>(new StoneCounter(Qt::red)));
    m_stoneCounters.push_back(QSharedPointer<StoneCounter>(new StoneCounter(Qt::white)));

    connect(m_stoneCounters[0].data(), SIGNAL(colorChanged(const QColor&, const QColor&)), this, SLOT(ensureSameColorIsUsedOnce(const QColor&, const QColor&)));
    connect(m_stoneCounters[1].data(), SIGNAL(colorChanged(const QColor&, const QColor&)), this, SLOT(ensureSameColorIsUsedOnce(const QColor&, const QColor&)));
    connect(m_stoneCounters[2].data(), SIGNAL(colorChanged(const QColor&, const QColor&)), this, SLOT(ensureSameColorIsUsedOnce(const QColor&, const QColor&)));
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

void CountingLogic::ensureSameColorIsUsedOnce(const QColor& oldColor, const QColor& newColor)
{
    for(QSharedPointer<StoneCounter>& counter: m_stoneCounters) {
        if(sender() != counter.data() && counter->color() == newColor) {
            counter->setProperty("color", oldColor);
        }
    }
}
