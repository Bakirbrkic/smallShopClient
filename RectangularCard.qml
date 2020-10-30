import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15


Rectangle{
    property int borderRadius: 20
    property int h: 50
    property int w: 50
    property string iconSource: ""
    property string cardTitleText: "value"
    property string cardText: "value"
    property string textColor: "pink"
    property string backgroundColor: "white"

    property string actionName

    signal rectangularCardPressed(string cardText, string actionName)


    height: h
    width: w
    color: "#00000000"

    Rectangle{
        color: backgroundColor
        height: parent.height-10
        width: parent.width-10
        anchors.centerIn: parent
        radius: borderRadius
        border.color: "lightgrey"

//        Image {
//            id:icon
//            height: (parent.height)-20
//            width: (parent.width/2)-5
//            anchors.verticalCenter: parent.verticalCenter
//            anchors.left: parent.left
//            anchors.leftMargin: 5
//            source: iconSource
//            anchors.fill: iconRask
//            fillMode: Image.PreserveAspectCrop
//        }

        Item {
            id: iconItem
            height: (parent.height)-10
            width: (parent.width/2)-5
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 5

            Image {
                id: icon
                height: (parent.height)
                width: (parent.width)
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                source: iconSource
                fillMode: Image.PreserveAspectCrop
                visible: false
            }

            Rectangle {
                id: mask
                radius: 15
                visible: false
                height: (parent.height)
                width: (parent.width)
            }

            OpacityMask {
                anchors.fill: icon
                source: icon
                maskSource: mask
            }
        }

        Column{
            width: (parent.width/2)-10
            anchors.right: parent.right
            anchors.rightMargin: 5
            topPadding: 15

            Text {
                text: cardTitleText
                wrapMode: Text.WordWrap
                width: parent.width
                font.pointSize: 20
                color: textColor
            }
            Text {
                text: cardText
                wrapMode: Text.WordWrap
                width: parent.width
                maximumLineCount: 5
                elide: Text.ElideRight
            }
        }

        MouseArea{
            anchors.fill: parent
            onReleased: {
                rectangularCardPressed(cardText, actionName);
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

