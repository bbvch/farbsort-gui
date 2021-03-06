#ifndef STONECOUNTER_H
#define STONECOUNTER_H

#include <QObject>
#include <QColor>

class StoneCounter : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QColor color READ color WRITE setColor  NOTIFY colorChanged)
    Q_PROPERTY(unsigned int count READ count RESET resetCount  NOTIFY countChanged)
    Q_PROPERTY(unsigned int averageTime READ averageTime NOTIFY averageTimeChanged)
    Q_PROPERTY(QString name READ name NOTIFY nameChanged)

signals:
    void countChanged();
    void averageTimeChanged();
    void colorChanged();
    void nameChanged();

public:
    explicit StoneCounter(const QColor color);
    void addStone(const unsigned int timeNeeded);

protected:
    QColor color() const;
    void setColor(const QColor color);
    unsigned int count() const;
    void resetCount();
    unsigned int averageTime() const;
    QString name() const;

private:
    QColor m_color{Qt::transparent};
    unsigned int m_count{0};
    unsigned int m_averageTime{0};
};

#endif // STONECOUNTER_H
