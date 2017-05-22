#ifndef COUNTINGLOGIC_H
#define COUNTINGLOGIC_H

#include "stonecounter.h"

#include <QObject>
#include <QColor>
#include <QVector>
#include <QSharedPointer>

class CountingLogic : public QObject
{
    Q_OBJECT
    Q_PROPERTY(StoneCounter* trayOneStoneCounter READ trayOneStoneCounter NOTIFY trayOneStoneCounterChanged)
    Q_PROPERTY(StoneCounter* trayTwoStoneCounter READ trayTwoStoneCounter NOTIFY trayTwoStoneCounterChanged)
    Q_PROPERTY(StoneCounter* trayThreeStoneCounter READ trayThreeStoneCounter NOTIFY trayThreeStoneCounterChanged)

public:
    explicit CountingLogic();

signals:
    void trayOneStoneCounterChanged();
    void trayTwoStoneCounterChanged();
    void trayThreeStoneCounterChanged();

public slots:
    StoneCounter* trayOneStoneCounter();
    StoneCounter* trayTwoStoneCounter();
    StoneCounter* trayThreeStoneCounter();
    void stoneReachedInTray(const int trayId, const int timeNeeded);

private:
    QVector<QSharedPointer<StoneCounter>> m_stoneCounters;
};

#endif // COUNTINGLOGIC_H

