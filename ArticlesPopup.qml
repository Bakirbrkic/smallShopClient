import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtLocation 5.12
import QtPositioning 5.12

Popup{
    property int articlenumid: -1
    property bool onList: false

    signal addItemToCart(int i)

    modal: true
    width: parent.width*0.8
    height: (imageItem.height - articlePopButtons.height) > 0 ? (imageItem.height + articlePopDecRow.height + 40) : (articlePopButtons.height + articlePopDecRow.height + 40)
    topMargin: (parent.height)/2
    leftMargin: parent.width*0.1

    Item {
        id: imageItem
        height: (parent.width/2)-5
        width: height
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.rightMargin: 5
        anchors.top: parent.top

        Image {
            id: articlePopImage
            height: (parent.height)
            width: (parent.width)
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
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
            anchors.fill: articlePopImage
            source: articlePopImage
            maskSource: mask
        }
    }
    Column{
        id: articlePopButtons
        width: (parent.width/2)-10
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        topPadding: 5
        spacing: 20

        Text {
            id: articlePopName
            wrapMode: Text.WordWrap
            width: parent.width
            font.pointSize: 20
            font.bold: true
            color: themeColourMain
            maximumLineCount: 3
        }

        Text {
            id: articlePopPrice
            wrapMode: Text.WordWrap
            width: parent.width
            font.pointSize: 15
            color: themeColourMain
            maximumLineCount: 3
        }

        Rectangle{
            color: onList ? "white" : themeColourMain
            border.color: onList ? themeColourMain : "white"
            height: 40
            width: parent.width
            Text {
                anchors.centerIn: parent
                color: onList ? themeColourMain : "white"
                font.bold: true
                text: onList ? "Dodano na vaš spisak" : "Dodaj na spisak"
            }
            MouseArea{
                anchors.fill: parent
                onPressed: {
                    if(!onList){
                        addItemToCart(articlenumid);
                        onList = !(onList);
                    }
                }
            }
        }
    }
    Row{
        id: articlePopDecRow
        anchors.top: (imageItem.height - articlePopButtons.height) > 0 ? imageItem.bottom : articlePopButtons.bottom
        anchors.margins: 10
        width: parent.width

        Text {
            id: articlePopDesc
            wrapMode: Text.WordWrap
            width: parent.width
            maximumLineCount: 5
            elide: Text.ElideRight
        }
    }

    function loadAndOpen(a, i){
        //var a = amodel.get(id); pass it from the article grid model
        articlenumid = i;
        articlePopName.text = a.name;
        articlePopDesc.text = "Opis artikla: " + a.description;
        articlePopImage.source = "https://api.sjedimnako.ba/shopClientDemo/"+ a.img;
        //articlePopImage.source = a.img;
        articlePopPrice.text = a.price + " KM";
        onList = a.addedToList;
        open();
    }
}
