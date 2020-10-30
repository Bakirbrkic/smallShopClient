import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15


Rectangle{
    property int h: 100
    property int w: 100
    property int borderRadius: 10
    property string themeColor: "pink"
    property bool showPills: false

    signal searchButton(string searchText)

    id: searchWrap
    width: w
    height: h
    color: "#00000000"

    Rectangle{
        id: searchBoxBackground
        radius: borderRadius
        anchors.centerIn: parent
        width: searchWrap.width-40
        height: searchWrap.height-10
        border.color: "lightgrey"

        TextField{
            id: searchBox
            width: searchBoxBackground.width-20
            height: searchBoxBackground.height
            font.pointSize: 20
            verticalAlignment: TextInput.AlignBottom
            anchors.centerIn: parent
            placeholderText: "Pretraga artikala i kategorija..."
            onEditingFinished: {
                console.log("[searchBox] editing finished");
                showPills = false;
                if(searchBox.text != "")
                    searchButton(searchBox.text);
                searchBox.focus = false;
            }
            onPressed: {
                console.log("[searchBox] pressed");
                showPills = true;
            }
        }

        Image {
            source: "media/media/srch-r.png"
            fillMode: Image.PreserveAspectFit
            height: searchBoxBackground.height/2
            width: height
            anchors.verticalCenter: searchBox.verticalCenter
            anchors.right: searchBox.right

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    searchBox.text = searchBox.text == "" ? searchBox.preeditText : searchBox.text;
                    if(searchBox.text != "")
                        searchButton(searchBox.text);
                    showPills = false;
                    searchBox.focus = false;
                }
            }
        }

        Rectangle{
            id:pillScroll
            visible: showPills
            height: searchBoxBackground.height*0.7
            width: searchBoxBackground.width
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.bottom
            anchors.topMargin: 5
            color: "#00000000"

            ScrollView{
                anchors.fill: parent
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                Row{
                    spacing: 5

                    function pillPress(pillText, actionName){
                        console.log("(pill) name: " + pillText + ", action: " + actionName);
                        searchBox.text = pillText;
                        searchBox.editingFinished();
                        searchButton(pillText);
                    }

                    PillButton{
                        pillText: "Čokolada"
                        h: searchBoxBackground.height*0.7
                        onPillPressed: {
                            parent.pillPress(pillText, actionName);
                        }
                    }

                    PillButton{
                        pillText: "Sladoled"
                        h: searchBoxBackground.height*0.7
                        onPillPressed: {
                            parent.pillPress(pillText, actionName);
                        }
                    }

                    PillButton{
                        pillText: "Bombone"
                        h: searchBoxBackground.height*0.7
                        onPillPressed: {
                            parent.pillPress(pillText, actionName);
                        }
                    }

                    PillButton{
                        pillText: "Keks"
                        h: searchBoxBackground.height*0.7
                        onPillPressed: {
                            parent.pillPress(pillText, actionName);
                        }
                    }
                }
            }
        }
    }
}
