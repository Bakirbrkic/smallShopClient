import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Item {

    property int h: 100
    property int w: 100
    property int borderRadius: 20
    property int discNum: 13
    property int optNum: 0
    property string themeColor: "pink"
    property string titleText: "value"

    signal discountButton
    signal optionsButton

    Rectangle{
        height: h
        width: w
        color: "#00000000"

        Rectangle{
            y: -20
            height: h-10
            width: w
            radius: borderRadius
            color: themeColor

            Rectangle{
                id: saleBtn
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height*0.5
                width: height
                radius: 100
                anchors.verticalCenterOffset: 7
                anchors.leftMargin: 8
                color: themeColor

                Image {
                    anchors.centerIn: parent
                    width: parent.width-4
                    height: width
                    source: "media/media/sale-w.png"
                    fillMode: Image.PreserveAspectFit
                }

                MouseArea{
                    anchors.fill: parent

                    onClicked: {
                        discountButton();
                    }
                }

                Rectangle{
                    id: discBadge
                    color: "orange"
                    radius: 100
                    height: parent.height/3
                    width: height
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        text: discNum
                        font.pixelSize: parent.height*0.8
                        anchors.centerIn: parent
                        color: "white"
                    }
                }

            }

            Text {
                id: title
                text: titleText
                color: "white"
                anchors.centerIn: parent
                anchors.verticalCenterOffset: 7
                font.pointSize: 24
            }

            Rectangle{
                id: optBtn
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height*0.5
                width: height
                radius: 100
                anchors.verticalCenterOffset: 7
                anchors.rightMargin: 8
                color: themeColor

                Image {
                    anchors.centerIn: parent
                    width: parent.width-4
                    height: width
                    source: "media/media/user-r.png"
                    fillMode: Image.PreserveAspectFit
                }

                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        //console.log("options btn")
                        optionsButton()
                    }
                }

                Rectangle{
                    id: optBadge
                    visible: optNum != 0
                    color: "orange"
                    radius: 100
                    height: parent.height/3
                    width: height
                    anchors.bottom: parent.bottom
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        text: optNum
                        font.pixelSize: parent.height*0.8
                        anchors.centerIn: parent
                        color: "white"
                    }
                }
            }

//            DropShadow{
//                anchors.fill: parent
//                horizontalOffset: 0
//                verticalOffset: 2
//                radius: 8.0
//                samples: 17
//                color: "#30000000"
//                source: parent
//            }
        }
    }
}
