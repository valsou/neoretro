import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    readonly property bool __isActiveFocus: activeFocus
    readonly property bool __isCurrentItem: ListView.isCurrentItem
    readonly property ListView __lv: ListView.view

    width: childrenRect.width
    height: __lv.height

    // Rectangle {
    //     anchors.fill: parent
    //     color: "#C6F0E3"
    // }

    Text {
        id: menuName

        height: parent.height

        text: modelData.name.toUpperCase()
        color: textColor
        font {
            family: fontSans.name
            weight: Font.DemiBold
            pixelSize: vpx(16)
        }
        verticalAlignment: Text.AlignVCenter
    }
}