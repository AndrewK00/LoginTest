import QtQuick 2.15
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import io.tester 1.0

Window {
    id: window
    width: 640
    height: 480
    visible: true
    color: "#2d5da3"
    title: qsTr("Quwi 0.1.295")

    Tester{
        id:test
        onPageChanged: mainBackground.state=page
        onSetHomePage: {homepage.username= "USER: "+ userName; homepage.urlImage= avatar}
        onError: {err.errortext = error; err.visible=true; err.title="Error: "+ code }


    }

    Rectangle{
        id:mainBackground
        anchors.fill: parent
        color:"#2d5da3"
        state:"page1"

        Page{
            id:page1
            title: "authorization page"
            background: Rectangle{ color:"#2d5da3"}
            anchors.fill: parent
            Label {
                id: label
                x: 298
                width: 26
                height: 15
                text: qsTr("QUWI")
                color:"#000000"
                anchors.top: image.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignBottom
                font.pointSize: 13
                font.family: "Arial"
                font.bold: true
                anchors.horizontalCenter: image.horizontalCenter
                anchors.topMargin: 25
            }

            Image {
                id: image
                x: 276
                width: 53
                height: 53
                anchors.top: parent.top
                source: "qrc:/quwi-logo.png"
                anchors.topMargin: 35
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                fillMode: Image.PreserveAspectFit
            }


            CustomTextInput{
                id: inEmail
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                selectionColor: "#2760b2"
                anchors.topMargin: 40
                texthint: "Email"
                validator: RegularExpressionValidator { regularExpression: /^.+@.+\..+$/ }
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter
                onTextChanged: isGoodEmail=true
                property bool isGoodEmail: true
                Text{
                    anchors.fill: parent;
                    visible: !parent.isGoodEmail && !parent.acceptableInput
                    color:"red"
                    font.pixelSize: 12
                    text:  parent.text + " is not a valid email"
                    horizontalAlignment: Text.AlignHCenter
                }

            }
            CustomTextInput{
                id: inPass
                texthint: "Password"
                echoMode: TextInput.Password
                inputMethodHints:Qt.ImhHiddenText
                anchors.top: inEmail.bottom
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                selectionColor: "#2760b2"
                anchors.topMargin: 20
                anchors.horizontalCenterOffset: 0
                anchors.horizontalCenter: parent.horizontalCenter

            }

            Button {
                id: button
                x: 186
                width: 285
                height: 50
                flat:true
                highlighted: true
                text: qsTr("Login")
                anchors.top: inPass.bottom
                anchors.topMargin: 20
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 12
                font.family: "Arial"
                onClicked: {
                    if(!inEmail.acceptableInput)
                        inEmail.isGoodEmail=false
                    else /*if(inPass.text.length>2) */
                    {
                        test.loginPass(inEmail.text,inPass.text)
                    }
                }

                background: Rectangle {
                    color: parent.down ? "#89a0c2" :
                                         (parent.hovered ? "#89a0c2" : "#588bd6")
                    radius: 5
                    border.color: "#5686cb"
                }
                display: AbstractButton.TextOnly
            }

            Text {
                id: text1
                color: "#8cb5ef"
                text: qsTr("Don't have an account? Register for free")
                anchors.top: button.bottom
                font.pixelSize: 12
                horizontalAlignment: Text.AlignHCenter
                anchors.topMargin: 50
                font.weight: Font.Light
                font.family: "arial"
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: Qt.openUrlExternally("https://quwi.com/signup");
                    onEntered: parent.font.underline=true;
                    onExited: parent.font.underline=false;
                }
            }

        }

        Page{
            id:page2
            anchors.fill: parent
            HomePage{
                id:homepage


            }
        }

        states: [
            State {
                name: "page2"
                PropertyChanges { target: page1; visible:false; }
                PropertyChanges { target: page2; visible:true; }
            },
            State {
                name: "page1"
                PropertyChanges { target: page2; visible:false; }
                PropertyChanges { target: page1; visible:true; }
            }


        ]
    }

    Dialog{
        id:err
        implicitWidth:ertxt.implicitWidth+20
        anchors.centerIn: parent
        modal: Qt.NonModal
        property string errortext: ""
        visible: false
        standardButtons: Dialog.Close
        title:"Error"
        contentData:
            Text{
            id:ertxt
            text: err.errortext
            anchors.fill: parent;

        }

    }


}
