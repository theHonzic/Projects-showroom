import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    width: 1440
    height: 960
    visible: true
    title: qsTr("The Game")


    GameGrid{

    }


    Rectangle{
        id: pomoc
        x:parent.width-200
        y:300
        color: "red"
        width: 64
        height: 64
        Image {
            id: pomocImage
            source: "Images/button.png"
            anchors.fill: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                map.doChange()

            }
        }
    }
    Arrow{
        id:arrowup
        anchors.bottom: pomoc.top
        anchors.right: pomoc.right
        anchors.bottomMargin: 20
        imagePath: "Images/arrowup.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                map.moveUp()
                map.doChange()
            }
        }
    }
    Arrow{
        id:arrowright
        anchors.left: pomoc.right
        anchors.leftMargin: 20
        anchors.top: pomoc.top
        imagePath: "Images/arrowright.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                map.moveRight()

            }
        }
    }
    Arrow{
        id:arrowdown
        anchors.top: pomoc.bottom
        anchors.left: pomoc.left
        anchors.topMargin: 20
        imagePath: "Images/arrowdown.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                map.moveDown()

            }
        }
    }
    Arrow{
        id:arrowleft
        anchors.top: pomoc.top
        anchors.right: pomoc.left
        anchors.rightMargin: 20
        imagePath: "Images/arrowleft.png"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                map.moveLeft()
            }
        }
    }
    Inventory{
        anchors.top: arrowdown.bottom
        anchors.right: parent.right
        anchors.rightMargin: 50
        anchors.topMargin: 20
    }
}
