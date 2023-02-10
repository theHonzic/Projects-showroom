import QtQuick 2.0



Rectangle{
    id: pomoc
    x:500
    y:200
    color: "grey"
    width: 64
    height: 64
    Image {
        id: pomocImage
        source: "Images/button.png"
        anchors.fill: parent
    }
}
Arrow{
    id:arrowup
    anchors.bottom: pomoc.top
    anchors.right: pomoc.right
    anchors.bottomMargin: 20
    imagePath: "Images/arrowup.png"
}
Arrow{
    id:arrowright
    anchors.left: pomoc.right
    anchors.leftMargin: 20
    anchors.top: pomoc.top
    imagePath: "Images/arrowright.png"
}
Arrow{
    id:arrowdown
    anchors.top: pomoc.bottom
    anchors.left: pomoc.left
    anchors.topMargin: 20
    imagePath: "Images/arrowdown.png"
}
Arrow{
    id:arrowleft
    anchors.top: pomoc.top
    anchors.right: pomoc.left
    anchors.rightMargin: 20
    imagePath: "Images/arrowleft.png"
}
