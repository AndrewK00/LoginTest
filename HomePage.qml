import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id: rectangle
    color:"black"
    anchors.fill: parent
    property bool clicked: false
    property string username: ""
    property string urlImage: ""


    Text{
        x: 279
        text:parent.username
        anchors.top: parent.top
        width: 56
        height: 17
        color:"white"
        font.pixelSize: 16
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.topMargin: 65
        anchors.horizontalCenter: parent.horizontalCenter
        font.bold: true
    }

    Button {
        id: button
        x: 186
        width: 285
        height: 50
        flat:true
        highlighted: true
        text: qsTr("LOGOUT")
        anchors.topMargin: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter:  parent.verticalCenter
        font.pointSize: 12
        font.family: "Arial"
        onClicked: {
            test.logout();
        }

        background: Rectangle {
            color: parent.down ? "#89a0c2" :
                                 (parent.hovered ? "#89a0c2" : "#588bd6")
            radius: 5
            border.color: "#5686cb"
        }
        display: AbstractButton.TextOnly
    }

    Image {
        id: image
        source: parent.urlImage
        x: 518
        width: 100
        height: 100
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: 23
        anchors.rightMargin: 22
        fillMode: Image.PreserveAspectFit
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:1}D{i:4}
}
##^##*/
