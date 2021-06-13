#include "logintester.h"
#include <QJsonArray>
#include <QJsonObject>

LoginTester::LoginTester(QObject *parent):QObject(parent)
{


    QObject::connect(&client,&HttpClient::emitError,this, &LoginTester::messageFromServer);
    QObject::connect(&client,&HttpClient::pageChanged,this, &LoginTester::pageChanged);
    QObject::connect(&client,&HttpClient::setHomePage,this, &LoginTester::setHomePage);

}

void LoginTester::loginPass(const QString &login, const QString &Password)
{
	const QMap<QString,QString> header{{"Content-Type:","application/json"},{"Client-Company:","udimi"},{"Client-Device:","timetracker"},{"Client-Timezone-Name:","UTC"}};
	const auto body =  QString(R"({
  "email": "%1",
  "password": "%2"
})").arg(login).arg(Password);
    client.PostRequest("auth/login",header,body);


}

void LoginTester::logout()
{
	const QMap<QString,QString> header{{"Content-Type:","application/json"},{"Token:",client.getToken()}};
    //"anywhere": true  // система разлогинит юзера на всех устройствах /// Нехочу этого делать
	const QString body(R"({
        "anywhere": false
    })");
    client.PostRequest("auth/logout",header,body);

}

void LoginTester::messageFromServer(const QJsonDocument &json,int responseCode)
{
	if(QJsonObject json_obj = json.object(); responseCode==417){
        //        "first_errors": {
        //                "email": "Email is not a valid email address.",
        //                "password": "Password cannot be blank."
        //            }

        auto js = json_obj["first_errors"].toObject();
        emit error(js["email"].toString() + " \n" + js["password"].toString(),QString::number(responseCode));


    }else if(responseCode==404)
    {
        //        "name": "Not Found",
        //           "message": "Page not found.",
        //           "code": 0,
        //           "status": 404,

        auto js =json_obj["previous"].toObject();
        emit error(json_obj["message"].toString() + " \n" + js["message"].toString(),QString::number(responseCode));

    }else if(responseCode==401){

        //        "name": "Unauthorized",
        //            "message": "You did not authenticate",
        //            "code": 0,
        //            "status": 401

        // auto js =jsonObj["previous"].toObject();
        emit error(json_obj["name"].toString() + " \n" +
                json_obj["message"].toString() + " \n",
                //js["message"].toString()
                QString::number(responseCode));

    }else if(responseCode==0){

       emit error("Sorry, no internet connection\n", QString::number(responseCode) );
    }







}
