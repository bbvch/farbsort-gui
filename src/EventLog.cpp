#include "EventLog.h"
#include <QDateTime>

// LogEntry Class start
LogEntry::LogEntry(const QString message, const LogEntry::LogLevel logLevel, const QString number, const QColor color)
    : m_message(message.trimmed())
    , m_number(number)
{
    switch(logLevel)
    {
    case LogLevel::Info :
        m_icon = "qrc:/info.png";
        break;
    case LogLevel::Warning :
        m_icon = "qrc:/warning.png";
        break;
    case LogLevel::Error :
        m_icon = "qrc:/error.png";
        break;
    }

    if(0 != color.alpha())
        m_color = color.name();
    else
        m_color = "transparent";

    // initialize every LogEntry with current system time
    QDateTime now = QDateTime::currentDateTime();
    m_date = now.toString("dd.MM.yyyy hh:mm:ss.zzz");
}

// getters for private members
const QString& LogEntry::message() const
{
    return m_message;
}

const QString& LogEntry::number() const
{
    return m_number;
}

const QString& LogEntry::icon() const
{
    return m_icon;
}

const QString& LogEntry::color() const
{
    return m_color;
}

const QString& LogEntry::date() const
{
    return m_date;
}
// Log Entry Class end


// EventLog Class start
EventLog::EventLog()
{
}

int EventLog::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_logEntries.count();
}

QVariant EventLog::data(const QModelIndex &index, int role) const
{
    if(index.row() < 0 || index.row() >= m_logEntries.count())
        return QVariant();

    const LogEntry &logEntry = m_logEntries[index.row()];
    switch(role) {
    case IconRole :
        return logEntry.icon();
        break;
    case DateRole :
        return logEntry.date();
        break;
    case NumberRole :
        return logEntry.number();
        break;
    case ColorRole :
        return logEntry.color();
        break;
    case MessageRole :
        return logEntry.message();
        break;
    }

    return QVariant();
}

void EventLog::addLogEntry(const QString message, const LogEntry::LogLevel logLevel, const QString no, const QColor color)
{
    // Add LogEntry to beginning of the list
    beginInsertRows(QModelIndex(), 0, 0);
    m_logEntries.prepend(LogEntry(message, logLevel, no, color));
    endInsertRows();
}

QHash<int, QByteArray> EventLog::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[IconRole] = "icon";
    roles[DateRole] = "date";
    roles[NumberRole] = "number";
    roles[ColorRole] = "color";
    roles[MessageRole] = "message";
    return roles;
}
// EventLog Class end
