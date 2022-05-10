#include "doglistsql.h"
#include "QObject"

dogListSQL::dogListSQL(QObject *parent) :
    QSqlQueryModel(parent)
{

    db = QSqlDatabase::addDatabase("QPSQL");
    db.setDatabaseName("Dogs");
    db.setPort(5432);
    db.setPassword("123");
    db.setUserName("postgres");

    QSqlQuery query(db);
    //db.open();

     _isConnectionOpen = true;

    if(!db.open())
    {
        qDebug() << db.lastError().text();
        _isConnectionOpen = false;
    }

    refresh();
}

QSqlQueryModel* dogListSQL::getModel(){
    return this;
}
bool dogListSQL::isConnectionOpen(){
    return _isConnectionOpen;
}
QHash<int, QByteArray> dogListSQL::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[Qt::UserRole + 2] = "Name";
    roles[Qt::UserRole + 3] = "Age";
    roles[Qt::UserRole + 4] = "Breed";
    roles[Qt::UserRole + 5] = "Owner";
    roles[Qt::UserRole + 1] = "Id_dog";

    return roles;
}

QVariant dogListSQL::data(const QModelIndex &index, int role) const
{
    QVariant value = QSqlQueryModel::data(index, role);
    if(role < Qt::UserRole-1)
    {
        value = QSqlQueryModel::data(index, role);
    }
    else
    {
        int columnIdx = role - Qt::UserRole - 1;
        QModelIndex modelIndex = this->index(index.row(), columnIdx);
        value = QSqlQueryModel::data(modelIndex, Qt::DisplayRole);
    }
    return value;
}

const char* dogListSQL::SQL_SELECT =
        "SELECT *"
        "FROM dogs";

void dogListSQL::refresh()
{
    this->setQuery(dogListSQL::SQL_SELECT,db);
    qDebug() << db.lastError().text();
}

void dogListSQL::add(const QString& name, const QString& age, const QString& breed, const QString& owner){

    QSqlQuery query(db);
    QString strQuery= QString("INSERT INTO dogs (Name,Age,Breed,Owner) VALUES ('%1', '%2', '%3', '%4', '%5')")
            .arg(name)
            .arg(age)
            .arg(breed)
            .arg(owner);
    bool a = query.exec(strQuery);
    qDebug() << a;

    refresh();
}

void dogListSQL::edit(const QString& name, const QString& age, const QString& breed, const QString& owner, const int Id_dog){

    QSqlQuery query(db);
    QString strQuery= QString("UPDATE dogs SET Name = '%1',Age = '%2',Breed = '%3',Owner = '%4'  WHERE Id = %6")
            .arg(name)
            .arg(age)
            .arg(breed)
            .arg(owner)
            .arg(Id_dog);
    bool a = query.exec(strQuery);
    qDebug() << a;

    refresh();
}

void dogListSQL::del(const int Id_dog){

    QSqlQuery query(db);
    QString strQuery= QString("DELETE FROM dogs WHERE Id = %1")
            .arg(Id_dog);
    bool a = query.exec(strQuery);
    qDebug() << a;

    refresh();
}
