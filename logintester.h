#ifndef LOGINTESTER_H
#define LOGINTESTER_H

#include <QObject>
#include "httpclient.h"

class LoginTester:public QObject
{
    Q_OBJECT
public:
    explicit LoginTester( QObject *parent=nullptr);

signals:
    void pageChanged(QString page);
    void error(QString error,QString code);
    void setHomePage(QString userName, QUrl avatar);

public slots:
    void loginPass(const QString& login, const QString& Password);
    void logout();
private slots:
    void messageFromServer(const QJsonDocument& json, int responseCode);
private:
    HttpClient client;

};

#endif // LOGINTESTER_H
