import QtQuick 2.15

FocusScope {
    id: root

    focus: true

    anchors.fill: parent

    MenuList {
        id: menuList

        focus: true

        anchors.left: root.left
        anchors.right: time.left
        anchors.top: time.top
        anchors.bottom: root.bottom
        anchors.bottomMargin: vpx(7)
    }

    Time {
        id: time
        anchors.bottom: root.bottom
        anchors.right: root.right
        anchors.bottomMargin: vpx(7)
    }

    Rectangle {
        id: lineUnderTop
        height: vpx(1)
        anchors.top: root.bottom
        anchors.left: root.left
        anchors.right: root.right
        color: textColor
    }

}