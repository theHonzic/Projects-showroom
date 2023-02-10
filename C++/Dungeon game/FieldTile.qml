import QtQuick 2.0

Rectangle {
    property int tileIndex: 0

    id: fieldTile
    width: 64
    height: 64
    Image {
        id: tileImage
        source: map.getImagePath(tileIndex)
        anchors.fill: parent

    }
    Image {
        id: hero
        source: map.getHero(tileIndex)
        anchors.fill: parent
    }

    Image {
        id: enemy
        source: map.getEnemy(tileIndex)
        anchors.fill: parent
    }

    Image {
        id: item
        source: map.getItem(tileIndex)
        anchors.fill: parent
    }


}
