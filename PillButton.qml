import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Rectangle {
    property string pillText: "value"
    property string actionName: pillText
    property int h: 50

    signal pillPressed(string text, string actionName)

    width: text.width+40
    height: h
    radius: 20
    border.color: "lightgray"

    Text {
        id: text
        anchors.centerIn: parent
        width: contentWidth
        text: pillText
    }

    MouseArea{
        anchors.fill: parent
        onReleased: {
            pillPressed(pillText, actionName);
        }
    }
}
