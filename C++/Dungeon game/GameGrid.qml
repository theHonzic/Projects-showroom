import QtQuick 2.0

Rectangle {
    property int gridWidth: 10
    anchors.fill: parent




    Image {
        id: backround
        source: "Images/background.jpg"
        anchors.fill: parent
    }

    Grid {
        x:380
        y:180
        id: gameGrid
        columns: gridWidth
        rows: gridWidth
        spacing: 5

        Repeater {
            model: map.m_map

            FieldTile {
                tileIndex: index
            }
        }
    }

}
