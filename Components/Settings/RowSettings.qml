import QtQuick 2.15
import QtQuick.Layouts 1.15

RowLayout {
    readonly property bool __isCurrentItem: ListView.isCurrentItem
    readonly property ListView __lv: ListView.view

    width: __lv.width
    height: vpx(40)

    Text {
        text: model.description
        Layout.fillWidth: true
        color: textColor
        font {
            family: regularDosis.name
            pixelSize: vpx(18)
        }
    }

    Text {
        text: model.value
        color: textColor
        font {
            family: regularDosis.name
            styleName: "SemiBold"
            pixelSize: vpx(18)
        }
        opacity: __isCurrentItem ? 1 : 0.5
    }
}