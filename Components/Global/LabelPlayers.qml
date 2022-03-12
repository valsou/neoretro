import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root

    property var players
    property real size

    width: text.width + size
    height: text.height + (size / 2)

    color: "transparent"
    border {
        width: vpx(1)
        color: "#3C8AC6"
    }

    Item {
        id: text
        width: childrenRect.width
        height: childrenRect.height
        anchors.centerIn: parent

        Text {
            text: {
                if (players > 1) {
                    return players+" PLAYERS"
                }
                else {
                    return players+" PLAYER"
                }
            }
            color: "#3C8AC6"
            font {
                family: fontSans.name
                weight: Font.ExtraBold
                pixelSize: size
            }
        }
    }
}