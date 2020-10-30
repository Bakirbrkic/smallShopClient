import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15


Rectangle{
    property int borderRadius: 10
    property int h: col.height + 20
    property int w: 50
    property string iconSource: ""
    property string cardTitleText: "value"
    property int amount: 0
    property double price: 0
    property string textColor: "pink"
    property string backgroundColor: "white"

    signal addAmount
    signal subAmount
    signal remove


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

        Item {
            id: iconItem
            height: parent.height-10
            width: (parent.width/4)-10
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
                radius: 5
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
            id: col
            width: (parent.width - iconItem.width - 20)
            anchors.right: parent.right
            anchors.rightMargin: 10
            topPadding: 5
            spacing: 5

            Row{
                width: parent.width
                Text {
                    id: titleTextElement
                    text: cardTitleText
                    maximumLineCount: 1
                    elide: Text.ElideRight
                    width: parent.width - priceBox.width - 5
                    wrapMode: Text.WordWrap
                    font.pointSize: 22
                    color: textColor
                }
                Text {
                    id: priceBox
                    text: price + " KM"
                    font.pointSize: 20
                    color: "darkgray"
                }
            }
            Row{
                height: titleTextElement.height
                width: parent.width
                Rectangle{
                    id: subAmountBtn
                    height: parent.height
                    width: height
                    color: textColor
                    Text {
                        text: "-"
                        color: "white"
                        anchors.centerIn: parent
                        font.pixelSize: parent.height
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed: {
                            subAmount();
                        }
                    }
                }
                Rectangle{
                    id: amountBox
                    height: parent.height
                    width: height
                    color: "white"
                    Text {
                        text: amount
                        color: textColor
                        anchors.centerIn: parent
                        font.pixelSize: parent.height-4
                    }
                }
                Rectangle{
                    id: addAmountBtn
                    height: parent.height
                    width: height
                    color: textColor
                    Text {
                        text: "+"
                        color: "white"
                        anchors.centerIn: parent
                        font.pixelSize: parent.height
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed: {
                            addAmount();
                        }
                    }
                }
                Rectangle{
                    width: parent.width - remBtn.width*4
                    height: parent.height
                    Text {
                        id: totalBox
                        anchors.centerIn: parent
                        text: (amount*price).toFixed(2) + " KM"
                        font.pointSize: 20
                        color: textColor
                    }
                }

                Rectangle{
                    id: remBtn
                    height: parent.height
                    width: height
                    color: "white"
                    border.color: textColor
                    Text {
                        id: t
                        text: "X"
                        color: textColor
                        anchors.centerIn: parent
                        font.pixelSize: parent.height-2
                    }
                    MouseArea{
                        anchors.fill: parent
                        onPressed: {
                            remove();
                        }
                    }
                }
            }
        }
    }
}

