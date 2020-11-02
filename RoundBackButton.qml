import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Rectangle{
    height: 40
    width: 40
    color: "#00000000"

    signal backButtonPressed

    Image {
        anchors.fill: parent
        source: "media/media/back-g.png"
        fillMode: Image.PreserveAspectFit
    }

    MouseArea{
        anchors.fill: parent
        onPressed: {
            backButtonPressed();
        }
    }
}
