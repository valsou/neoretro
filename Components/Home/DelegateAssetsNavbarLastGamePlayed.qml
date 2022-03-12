import QtQuick 2.15

Item {
    readonly property ListView __lv: ListView.view
    readonly property bool __isCurrentItem: ListView.isCurrentItem

    width: __lv.width / __lv.count
    height: __lv.height
    scale: __isCurrentItem ? 1.0 : 0.7

    Rectangle {
        width: height
        height: parent.height
        anchors.centerIn: parent
        radius: height
        color: "black"
        opacity: __isCurrentItem ? 0.2 : 0.06

    }
}