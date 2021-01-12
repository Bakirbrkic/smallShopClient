import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtLocation 5.12
import QtPositioning 5.12
import QtQuick.Layouts 1.3

Popup{
    property ListModel cartmodel: ListModel {
        id: cartModel
    }
    modal: true
    height: parent.height*0.9
    width: parent.width*0.9
    topMargin: parent.height*0.08
    leftMargin: parent.width*0.05
    id:cpop

    Column{
        id: column
        anchors.fill: parent

        Rectangle{
            id: cartTotalMenu
            width: parent.width
            height: parent.height*0.1

            RoundBackButton{
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                onBackButtonPressed: {
                    cpop.close();
                }
            }

            Row{
                spacing: 2
                anchors.centerIn: parent
                Text {
                    anchors.bottom: parent.bottom
                    text: "Broj artikala:"
                }
                Text {
                    anchors.bottom: parent.bottom
                    text: cartModel.count
                    color: root.themeColourMain
                    font.pointSize: 18
                }
                Text {
                    anchors.bottom: parent.bottom
                    text: ", ukupan iznos:"
                }
                Text {
                    id: totalPriceTxt
                    anchors.bottom: parent.bottom
                    color: root.themeColourMain
                    font.pointSize: 18
                }
                Text {
                    anchors.bottom: parent.bottom
                    color: root.themeColourMain
                    font.pointSize: 18
                    text: " KM"
                }
            }
        }

        ScrollView{
            id: articlesScroll
            width: parent.width
            height: parent.height*0.8
            clip: true


            Component{
                id: cdelegate
                CartItemCard{
                    w: cartlist.width
                    backgroundColor: "white"
                    textColor: root.themeColourMain
                    iconSource: "https://api.sjedimnako.ba/shopClientDemo/"+model.img
                    //iconSource: model.img
                    cardTitleText: model.name
                    amount: model.amount
                    price: model.price

                    onAddAmount: {
                        model.amount++;
                        computeTotal();
                    }
                    onSubAmount: {
                        if(model.amount > 1){
                            model.amount--;
                            computeTotal();
                        }
                    }
                    onRemove: {
                        cartModel.remove(cartlist.indexAt(this.x, this.y));
                        computeTotal();
                    }
                }
            }

            ListView {
                id: cartlist
                anchors.fill: parent
                model: cartModel
                delegate: cdelegate
            }
        }

        Rectangle{
            id: orderMenu
            color: root.themeColourMain
            width: parent.width
            height: parent.height*0.1
            visible: cartModel.count != 0 ? true : false
            Text {
                text: "Naruči"
                color: "white"
                font.pixelSize: parent.height*0.6
                anchors.centerIn: parent
            }
        }

    }

    function computeTotal(){
        var tot = 0;
        for(var i = cartModel.count-1; i >= 0; i--){
            tot+= (cartModel.get(i).price * cartModel.get(i).amount)
        }
        totalPriceTxt.text = tot.toFixed(2);
    }
    onAboutToShow: {
        computeTotal();
    }
}
