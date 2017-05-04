#ifndef EVENTLOG_H
#define EVENTLOG_H

#include <QAbstractListModel>
#include <QList>
#include <QColor>

class LogEntry
{
public:
    enum class LogLevel {
        Info,
        Warning,
        Error
    };

    LogEntry(const QString message, const LogLevel logLevel = LogLevel::Info, const QString number = "", const QColor color = Qt::transparent);
    const QString& message() const;
    const QString& number() const;
    const QString& icon() const;
    const QString& color() const;
    const QString& date() const;

private:
    QString m_message;
    QString m_number;
    QString m_icon;
    QString m_color;
    QString m_date;
};


class EventLog : public QAbstractListModel
{
    Q_OBJECT

public:
    enum EventLogRoles {
        IconRole = Qt::UserRole + 1,
        DateRole,
        NumberRole,
        ColorRole,
        MessageRole,
    };

    EventLog();
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

public slots:
    void addLogEntry(const QString message, const LogEntry::LogLevel logLevel, const QString number, const QColor color);

protected:
    QHash<int, QByteArray> roleNames() const;

private:
    QList<LogEntry> m_logEntries;
};

#endif // EVENTLOG_H

