import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

//anchors.top: searchBar.bottom

Rectangle{
    property string dragHandleColor: "gray"
    property int heightWhenOpen: 500//(root.height - y + radius)
    property int borderRadius: 20
    property int w: 50
    property bool shadow: false

    property ListModel amodel: ListModel {
        id: articlesModel
    }

    signal dragToClose();
    signal articleSelected(int id);

    id: articlesGrid
    width: w
    height: heightWhenOpen
    color: "white"
    radius: borderRadius
    anchors.bottomMargin: -borderRadius
    border.color: "lightgrey"

    //Drag Handle
    Rectangle{
        id: dragHandle
        height: 50
        width: parent.width
        anchors.top: parent.top
        color: "#00000000"

        Rectangle{
            height: 5
            width: 40
            radius: 10
            color: dragHandleColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

        }

        RoundBackButton{
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
        }

        MouseArea{
            anchors.fill: parent
            onPressed: {
                dragToClose();
                articlesModel.clear();
                alist.visible = false;
                animation.visible = true;
            }
        }
    }

    //start showing products here

    ScrollView{
        id: articlesScroll
        width: parent.width
        anchors.top: dragHandle.bottom
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20
        clip: true
        //color: "green"

        Component{
            id: adelegate
            RectangularCard{
                w: articlesGrid.width
                h: articlesGrid.height*0.25
                backgroundColor: "white"
                textColor: root.themeColourMain
                iconSource: "https://api.sjedimnako.ba/shopClientDemo/"+model.img
                //iconSource: model.img
                cardTitleText: model.name
                cardText: model.price + "KM, " + model.description
                actionName: model.name

                onRectangularCardPressed: {
                    articleSelected(alist.indexAt(this.x, this.y));
                }
            }
        }

        ListView {
            id: alist
            visible: false
            anchors.fill: parent
            model: articlesModel
            delegate: adelegate
        }
        AnimatedImage {
            id: animation
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: "media/media/loader.gif"
        }
    }

    //end showing products here

    function loadAllItems(){
        var model;

        request('https://api.sjedimnako.ba/shopClientDemo/all.json', function (o) {
            // translate response into object
            model = JSON.parse(o.responseText);

            for(var i = model.length-1; i >= 0; i--){
                model[i].addedToList = false;
                articlesModel.append(model[i]);
            }
            alist.visible = true;
            animation.visible = false;
        });
    }

//        function loadAllItems(){
//            var model;

//            request('http://192.168.0.11/wptut/index.php/wp-json/wp/v2/shopitems?categories=3', function (o) {
//                // translate response into object
//                //model = JSON.parse(o.responseText);
//                var response = JSON.parse(o.responseText);


//                for(var i = response.length-1; i >= 0; i--){
//                    var newItem = {};
//                    newItem.name = response[i].title.rendered;
//                    newItem.price = response[i].cmb2.smallshop_rest_metabox.price;
//                    newItem.description = response[i].cmb2.smallshop_rest_metabox.itemdescription;
//                    newItem.img = response[i].cmb2.smallshop_rest_metabox.image;
//                    newItem.addedToList = false;
//                    articlesModel.append(newItem);
//                }
//                alist.visible = true;
//                animation.visible = false;
//            });
//        }

    function loadItems(query){
        var model;
        var i = query.toLowerCase();
        var q = "https://api.sjedimnako.ba/shopClientDemo/"+i+".json";
        console.log(q);
        request(q, function (o) {
            // translate response into object
            model = JSON.parse(o.responseText);
            articlesModel.clear();

            for(var i = model.length-1; i >= 0; i--){
                model[i].addedToList = false;
                articlesModel.append(model[i]);
            }
            alist.visible = true;
            animation.visible = false;
        });
    }

//            function loadItems(query){
//                var model;
//                var i = query.toLowerCase();

//                if(i[0] === 'c' && i[1] === '!')
//                    i = "http://192.168.0.11/wptut/index.php/wp-json/wp/v2/shopitems?categories=" + i.substr(2);
//                else
//                    i = 'http://192.168.0.11/wptut/index.php/wp-json/wp/v2/shopitems?search='+i
//                console.log(i);

//                request(i, function (o) {
//                    //clear all items in articlesGrid
//                    articlesModel.clear();
//                    // translate response into object
//                    //model = JSON.parse(o.responseText);
//                    var response = JSON.parse(o.responseText);
//                    console.log(response.length)

//                    for(var i = response.length-1; i >= 0; i--){
//                        var newItem = {};
//                        newItem.name = response[i].title.rendered;
//                        newItem.price = response[i].cmb2.smallshop_rest_metabox.price;
//                        newItem.description = response[i].cmb2.smallshop_rest_metabox.itemdescription;
//                        newItem.img = response[i].cmb2.smallshop_rest_metabox.image;
//                        newItem.addedToList = false;
//                        articlesModel.append(newItem);
//                    }
//                    alist.visible = true;
//                    animation.visible = false;
//                });
//            }

    //docs at https://gist.github.com/40/3192269
    function request(url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = (function(myxhr) {
            return function() {
                if(myxhr.readyState === 4) callback(myxhr)
            }
        })(xhr);
        xhr.open('GET', url, true);
        xhr.send('');
    }
}
