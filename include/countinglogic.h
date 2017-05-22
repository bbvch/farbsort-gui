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
    // counters
    Q_PROPERTY(StoneCounter* trayOneStoneCounter READ trayOneStoneCounter NOTIFY trayOneStoneCounterChanged)
    Q_PROPERTY(StoneCounter* trayTwoStoneCounter READ trayTwoStoneCounter NOTIFY trayTwoStoneCounterChanged)
    Q_PROPERTY(StoneCounter* trayThreeStoneCounter READ trayThreeStoneCounter NOTIFY trayThreeStoneCounterChanged)
    // color assignment
    Q_PROPERTY(QColor trayOneColor READ trayOneColor WRITE setTrayOneColor  NOTIFY trayOneColorChanged)
    Q_PROPERTY(QColor trayTwoColor READ trayTwoColor WRITE setTrayTwoColor  NOTIFY trayTwoColorChanged)
    Q_PROPERTY(QColor trayThreeColor READ trayThreeColor WRITE setTrayThreeColor  NOTIFY trayThreeColorChanged)

public:
    explicit CountingLogic();

signals:
    void trayOneColorChanged();
    void trayTwoColorChanged();
    void trayThreeColorChanged();
    void trayOneStoneCounterChanged();
    void trayTwoStoneCounterChanged();
    void trayThreeStoneCounterChanged();

public slots:
    StoneCounter* trayOneStoneCounter();
    StoneCounter* trayTwoStoneCounter();
    StoneCounter* trayThreeStoneCounter();
    void stoneReachedInTray(const int trayId, const int timeNeeded);

protected:
    // getter
    QColor trayOneColor() const { return m_trayOneColor; }
    QColor trayTwoColor() const { return m_trayTwoColor; }
    QColor trayThreeColor() const { return m_trayThreeColor; }
    // setter
    void setTrayOneColor(const QColor color);
    void setTrayTwoColor(const QColor color);
    void setTrayThreeColor(const QColor color);

private:
    QColor m_trayOneColor;
    QColor m_trayTwoColor;
    QColor m_trayThreeColor;
    QVector<QSharedPointer<StoneCounter>> m_stoneCounters;
};

#endif // COUNTINGLOGIC_H

