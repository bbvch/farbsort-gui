#ifndef STONECOUNTER_H
#define STONECOUNTER_H

#include <QObject>

class StoneCounter : public QObject
{
    Q_OBJECT
    Q_PROPERTY(unsigned int count READ count RESET resetCount  NOTIFY countChanged)
    Q_PROPERTY(unsigned int averageTime READ averageTime WRITE setAverageTime  NOTIFY averageTimeChanged)

signals:
    void countChanged();
    void averageTimeChanged();

public:
    void addStone(const unsigned int timeNeeded);


protected:
    unsigned int count() const;
    void resetCount();
    unsigned int averageTime() const;
    void setAverageTime(const unsigned int averageTime);

private:
    unsigned int m_count{0};
    unsigned int m_averageTime{0};
};

#endif // STONECOUNTER_H
