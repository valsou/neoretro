import QtQuick 2.15

Item {
    id: root
    readonly property bool __isCurrentItem: ListView.isCurrentItem
    readonly property bool __isActiveFocus: activeFocus
    readonly property ListView __lv: ListView.view

    width: childrenRect.width
    height: __lv.height

    Item {
        width: childrenRect.width
        height: parent.height * 0.7
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
        }

        Text {
            id: title
            anchors {
                baseline: parent.bottom
            }
            text: modelData.name
            font {
                family: fontSans.name
                pixelSize: __isCurrentItem ? parent.height : parent.height * 0.8
            }
            color: "white"
            opacity: __isCurrentItem ? 1 : 0.1
        }
    }

}