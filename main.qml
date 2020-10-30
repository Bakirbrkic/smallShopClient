import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtLocation 5.12
import QtPositioning 5.12

import StatusBar 0.1


ApplicationWindow {

    property string titleName: "VašaProdavnica.ba"
    property string themeColourMain: "#b20726" //frisa color: "#e8308a"

    StatusBar{
        theme: StatusBar.Dark //dark background WHITE TEXT
        color: themeColourMain
    }

    visible: true
    width: 450
    height: 800
    id: root

    background: Rectangle{
        Image {
            anchors.fill: parent
            id: mapToBe

            Plugin {
                id: osmPlugin
                name: "osm"
            }

            Map {
                id: map
                height: parent.height
                width: parent.width
                plugin: osmPlugin
                center: QtPositioning.coordinate(43.845,18.36) // Sa
                zoomLevel: 13
                MapQuickItem{
                    id: mloc1
                    coordinate {
                        latitude: 43.831714
                        longitude: 18.344818
                    }
                    anchorPoint.x: (sourceItem.width/2)
                    anchorPoint.y: sourceItem.height

                    sourceItem: Image {
                        source: "media/media/shopmm-r-s.png"
                    }
                }
                MapQuickItem{
                    id: mloc2
                    coordinate {
                        latitude: 43.855596
                        longitude: 18.384075
                    }
                    anchorPoint.x: (sourceItem.width/2)
                    anchorPoint.y: sourceItem.height

                    sourceItem: Image {
                        source: "media/media/shopmm-r-s.png"
                    }
                }
                CoordinateAnimation{
                    id: mapAnimation
                    target: map
                    property: "center"
                    from: map.center
                    duration: 200
                }
            }
        }
    }

    header: TopBar{
        id: topBar
        h: 110
        w: root.width
        themeColor: root.themeColourMain
        titleText: root.titleName
        discNum: 14
        optNum: cartPop.cartmodel.count

        onDiscountButton: {
            console.log("[topBar] Discount Button signal caught");
        }

        onOptionsButton: {
            console.log("[topBar] Options Button signal caught");
            cartPop.open();
        }
    }

    Rectangle{
        id: homePage
        anchors.fill: parent
        color: "transparent"

        SearchBox{
            id: searchBar
            y: 90
            h: 70
            w: root.width
            z: 100

            onSearchButton: {
                console.log("[searchBar] Search Button signal caught, search text: " + searchText);
                articles.loadItems(searchText);
                showGrid();
            }
        }

        CartPopup{
            id: cartPop
        }

        ScrollView{
            id: scroll
            anchors.bottom: parent.bottom
            bottomPadding: 10
            width: parent.width
            height: parent.height*0.25

            PropertyAnimation {
                id: scrollAnimation
                duration: 200
            }

            Row{
                anchors.fill: parent
                spacing: 0

                SquareCard{
                    id: allItems
                    h: parent.height
                    backgroundColor: "white"
                    textColor: root.themeColourMain
                    iconSource: "media/media/shopbag-r.png"
                    cardText: "Svi artikli"
                    actionName: "allItemsBtn"

                    onSquareCardPressed: {
                        console.log("[allItems] SquareCardPressed signal caught, "+ actionName);
                        articles.loadAllItems();
                        showGrid();
                    }
                }

                SquareCard{
                    id: myItems
                    h: parent.height
                    backgroundColor: "white"
                    textColor: root.themeColourMain
                    iconSource: "media/media/user.png"
                    cardText: "Moj Spisak"
                    actionName: "myItemsBtn"

                    onSquareCardPressed: {
                        console.log("[myItems] SquareCardPressed signal caught, "+ actionName);
                        cartPop.open();
                    }
                }

                RectangularCard{
                    id: loc1
                    h: parent.height
                    w: root.width*0.8
                    backgroundColor: "white"
                    textColor: root.themeColourMain
                    iconSource: "media/media/loc1.jpg"
                    cardTitleText: "Lokacija Br. 1"
                    cardText: "BranilacaDBR 5.\n +387 33 456 654\n Pon. - Pet. 8:00 - 16:00"
                    actionName: "location1"

                    onRectangularCardPressed: {
                        console.log("[loc1] RectangularCardPressed signal caught, "+ actionName);
                        mapAnimation.to = mloc1.coordinate;
                        mapAnimation.start();
                    }
                }

                RectangularCard{
                    id: loc2
                    h: parent.height
                    w: root.width*0.8
                    backgroundColor: "white"
                    textColor: root.themeColourMain
                    iconSource: "media/media/loc2.jpg"
                    cardTitleText: "Very long Location Name Two"
                    cardText: "Some very long explanation text holding working hours info, locations address and myb telephone number and fax number"
                    actionName: "location2"

                    onRectangularCardPressed: {
                        console.log("[loc2] RectangularCardPressed signal caught, "+ actionName);
                        mapAnimation.to = mloc2.coordinate;
                        mapAnimation.start();
                    }
                }

                SquareCard{
                    id: igramBtn
                    h: parent.height
                    backgroundColor: "white"
                    textColor: root.themeColourMain
                    iconSource: "media/media/igram-r.png"
                    cardText: "Prati nas!"
                    actionName: "instagramBtn"

                    onSquareCardPressed: {
                        console.log("[igramBtn] SquareCardPressed signal caught, "+ actionName);
                    }
                }

                SquareCard{
                    id: fbBtn
                    h: parent.height
                    backgroundColor: "white"
                    textColor: root.themeColourMain
                    iconSource: "media/media/fb.png"
                    cardText: "Facebook"
                    actionName: "facebookBtn"

                    onSquareCardPressed: {
                        console.log("[fbBtn] SquareCardPressed signal caught, "+ actionName);
                    }
                }

            }
        }

        ArticlesGrid{
            id: articles
            heightWhenOpen: (root.height - (searchBar.y + searchBar.height) + articles.borderRadius)
            anchors.bottom: homePage.bottom
            w: root.width
            height: 0

            SmoothedAnimation {
                id: articlesAnimation
                duration: 500

                onStarted: {
                    articles.shadow = false;
                }
                onStopped: {
                    articles.shadow = true;
                }
            }

            onDragToClose: {
                console.log("[articles] dragToClose signal caught");
                hideGrid();
            }

            onArticleSelected: {
                console.log("[Articles] selected article no: "+ id + " name: " + amodel.get(id).name);
                articlePop.loadAndOpen(amodel.get(id), id);
            }

            ArticlesPopup{
                id: articlePop
                onAddItemToCart: {
                    console.log("[articlePop] add item to cart detected, item i: " + i);
                    //load the listitem from all articles
                    var newCartItem = articles.amodel.get(i);
                    //append list item to cartlist,
                    //TODO: check if the item is already inthere (by comparing names) if so dont add it again
                    var add = true;
                    if(cartPop.cartmodel.count > 0){
                        for(var j = cartPop.cartmodel.count; j--; j >= 0){
                            console.log("[articlePop] comparing item: " + newCartItem.name + " and " + cartPop.cartmodel.get(j).name);
                            if(newCartItem.name === cartPop.cartmodel.get(j).name){
                                console.log("[articlePop] item already in the cart");
                                add = false;
                                break;
                            }
                        }
                    }
                    if(add){
                        cartPop.cartmodel.append(newCartItem);
                        cartPop.cartmodel.setProperty(cartPop.cartmodel.count-1, "amount", 1);
                    }
                    //update all-articles-list so you know that the item was already in the cart-list
                    articles.amodel.setProperty(i, "addedToList", true);
                }
            }
        }

    }
    Component.onCompleted:{
        console.log("[root]: on completed");
    }

    function showGrid(){
        scrollAnimation.property = "height";
        scrollAnimation.target = scroll;
        scrollAnimation.to = 0;
        scrollAnimation.duration = 300;
        scrollAnimation.start();

        articlesAnimation.property = "height";
        articlesAnimation.target = articles;
        articlesAnimation.to = articles.heightWhenOpen;
        articlesAnimation.start();
    }
    function hideGrid(){
        articlesAnimation.property = "height";
        articlesAnimation.target = articles;
        articlesAnimation.to = 0;//articles.heightWhenOpen;
        articlesAnimation.start();

        scrollAnimation.property = "height";
        scrollAnimation.target = scroll;
        scrollAnimation.to = scroll.parent.height*0.25;
        scrollAnimation.duration = 800;
        scrollAnimation.start();
    }
}

