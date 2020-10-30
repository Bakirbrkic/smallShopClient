import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15


Rectangle{
    property int borderRadius: 20
    property int h: 50
    property string iconSource: ""
    property string cardText: "value"
    property string textColor: "pink"
    property string backgroundColor: "white"

    property string actionName

    signal squareCardPressed(string cardText, string actionName)

    height: h
    width: h
    color: "#00000000"

    Rectangle{
        color: backgroundColor
        height: parent.height-10
        width: parent.width-10
        anchors.centerIn: parent
        radius: 20
        border.color: "lightgrey"

        Image {
            id: icon
            source: iconSource
            width: parent.height/2
            height: width
            fillMode: Image.PreserveAspectFit
            anchors.centerIn: parent
        }
        Text {
            text: cardText
            color: textColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: icon.bottom
        }

        MouseArea{
            anchors.fill: parent
            onReleased: {
                squareCardPressed(cardText, actionName);
            }
        }

//        DropShadow{
//            anchors.fill: parent
//            horizontalOffset: 0
//            verticalOffset: 1
//            radius: 8.0
//            samples: 17
//            color: "#30000000"
//            source: parent
//        }
    }
}

