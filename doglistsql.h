#ifndef DOGLISTSQL_H
#define DOGLISTSQL_H

#include <QtSql>

class dogListSQL: public QSqlQueryModel
{
    Q_OBJECT

    Q_PROPERTY(QSqlQueryModel* dogModel READ getModel CONSTANT)
    Q_PROPERTY(bool IsConnectionOpen READ isConnectionOpen CONSTANT)

public:
    explicit dogListSQL(QObject *parent);
    void refresh();
    QHash<int, QByteArray> roleNames() const override;
    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const override;

    Q_INVOKABLE void add(const QString& name, const QString& age, const QString& breed, const QString& owner);
    Q_INVOKABLE void del(const int index);
    Q_INVOKABLE void edit(const QString& name, const QString& age, const QString& breed, const QString& owner, const int index);

signals:

public slots:

private:
    const static char* SQL_SELECT;
    QSqlDatabase db;
    QSqlQueryModel *getModel();
    bool _isConnectionOpen;
    bool isConnectionOpen();
};

#endif // DOGLISTSQL_H
