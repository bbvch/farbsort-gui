#include "stonecounter.h"

#include <QtGlobal>

QColor StoneCounter::color() const
{
    return m_color;
}

void StoneCounter::setColor(const QColor color)
{
    if(color != m_color) {
        m_color = color;
        emit colorChanged();
        emit nameChanged();
    }
}

unsigned int StoneCounter::count() const
{
    return m_count;
}

void StoneCounter::resetCount()
{
    if(0 != m_count) {
        m_count = 0;
        emit countChanged();
    }
}

unsigned int StoneCounter::averageTime() const
{
    return m_averageTime;
}

QString StoneCounter::name() const
{
    if(QColor(Qt::blue) == m_color) {
        return tr("blue");
    }
    if(QColor(Qt::red) == m_color) {
        return tr("red");
    }
    if(QColor(Qt::white) == m_color) {
        return tr("white");
    }
    return tr("undefined");
}

StoneCounter::StoneCounter(const QColor color)
    : m_color(color)
{
}

void StoneCounter::addStone(const unsigned int timeNeeded)
{
    const unsigned int oldCount = m_count;
    m_count++;
    emit countChanged();

    const unsigned int oldAverageTime = m_averageTime;
    if(m_averageTime > 0) {
        m_averageTime = ((oldCount * m_averageTime) + timeNeeded) / m_count;
    } else {
        m_averageTime = timeNeeded;
    }
    if(oldAverageTime != m_averageTime) {
        emit averageTimeChanged();
    }
}

