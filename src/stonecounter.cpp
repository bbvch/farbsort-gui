#include "stonecounter.h"


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

void StoneCounter::setAverageTime(const unsigned int averageTime)
{
    if(averageTime != m_averageTime) {
        m_averageTime = 0;
        emit averageTimeChanged();
    }
}

void StoneCounter::addStone(const unsigned int timeNeeded)
{
    m_count++;
    emit countChanged();

    unsigned int oldTime = m_averageTime;
    if(m_averageTime > 0) {
        m_averageTime = (((m_count - 1) * m_averageTime) + timeNeeded) / m_count;
    } else {
        m_averageTime = timeNeeded;
    }
    if(oldTime != m_averageTime) {
        averageTimeChanged();
    }
}

