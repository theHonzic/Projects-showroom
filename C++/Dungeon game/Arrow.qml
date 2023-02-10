import QtQuick 2.0

Rectangle{
    height: 64
    width: 64
    color: "blue"
    property string imagePath: ""
    Image {
        id: arrowupImage
        source: imagePath
        anchors.fill: parent
    }
}
