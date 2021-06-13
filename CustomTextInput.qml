import QtQuick 2.15
import QtQuick.Controls 2.15


TextInput {
    id: textInput
    x: 271
    width: 285
    height: 50
    property string texthint: "Email"
    color: "#d9dee5"
    anchors.top: label.bottom
    font.pixelSize: 14

    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
    font.hintingPreference: Font.PreferDefaultHinting
    overwriteMode: true
    activeFocusOnPress: true


    Rectangle {
        color: "#174588"
        radius: 5
        border.color: "#5686cb"
        anchors.fill: parent
        z:-1
        Text{
            color: "#648dad"
            text: texthint
            font.family: "Arial"
            font.pixelSize: 14
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            visible: !textInput.text && !textInput.activeFocus

        }

    }
}

