import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root

    property var genre
    property real size

    width: text.width + size
    height: text.height + (size / 2)

    color: "#EAF6FF"

    Item {
        id: text
        width: childrenRect.width
        height: childrenRect.height
        anchors.centerIn: parent

        Text {
            text: genre
            color: "#3C8AC6"
            font {
                family: fontSans.name
                pixelSize: size
            }
        }
    }
}