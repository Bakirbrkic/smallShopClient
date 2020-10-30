import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Rectangle{
    height: 40
    width: 40
    radius: 20
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.margins: 10

    Text {
        anchors.centerIn: parent
        text: "<-"
    }

    MouseArea{
        anchors.fill: parent
        onPressed: {
            dragToClose();
        }
    }

    DropShadow{
        anchors.fill: parent
        horizontalOffset: 0
        verticalOffset: 1
        radius: 5.0
        samples: 17
        color: "#30000000"
        source: parent
    }
}
