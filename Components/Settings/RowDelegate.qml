import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQml.Models 2.15

RowLayout {
    readonly property bool __isCurrentItem: ListView.isCurrentItem
    readonly property ListView __lv: ListView.view

    width: __lv.width
    // height: childrenRect.height

    opacity: __isCurrentItem && __isActiveFocus ? 1 : 0.2

    ColumnLayout {
        Layout.preferredWidth: parent.width * 0.7
        Layout.alignment: Qt.AlignLeft

        spacing: 0

        Text {
            text: modelData.title
            color: "white"
            font {
                family: global.fonts.sans
                pixelSize: vpx(18)
            }
        }

        Text {
            Layout.preferredWidth: parent.width
            text: modelData.description
            color: "white"
            font {
                family: global.fonts.sans
                styleName: "Light"
                pixelSize: vpx(14)
            }
            wrapMode: Text.Wrap
        }
    }

    Text {
        Layout.alignment: Qt.AlignRight

        readonly property bool isBool: (typeof modelData.value == "boolean")
        text: {
            if (isBool) {
                if (modelData.value == true) { return "\ue834" }
                else { return "\ue835" }
            }
            return modelData.value
        }
        color: "white"
        font {
            family: isBool ? googleMaterial.name : regularDosis.name
            styleName: "SemiBold"
            pixelSize: vpx(22)
        }
        opacity: __isCurrentItem ? 1 : 0.3
    }


}