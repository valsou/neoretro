import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {

    readonly property int xMargins: vpx(12)
    readonly property int yMargins: vpx(3)
    readonly property int count: collections[currentCollectionIndex].games.count
    readonly property int fontSize: vpx(18)

    width: iconMetrics.width + valueMetrics.width + xMargins * 2
    height: iconMetrics.height > valueMetrics.height ? iconMetrics.height + yMargins * 2 : valueMetrics.height + yMargins * 2

    color: Qt.rgba(backgroundColor.r, backgroundColor.g, backgroundColor.b, 0.15)
    // border {
    //     width: vpx(1)
    //     color: textColor
    // }

    Behavior on width {
        PropertyAnimation { properties: "width"; easing.type: Easing.InOutQuad }
    }

    TextMetrics {
        id: iconMetrics
        text: "\ue0b8"
        font.family: googleMaterial.name
        font.pixelSize: fontSize
    }

    TextMetrics {
        id: valueMetrics
        text: count+" games"
        font.family: regularDosis.name
        font.pixelSize: fontSize
    }

    RowLayout {
        anchors.centerIn: parent

        Layout.margins: vpx(10)

        Text {
            id: icon
            text: iconMetrics.text
            font.family: googleMaterial.name
            font.pixelSize: fontSize
            color: textColor
        }

        Text {
            id: value
            text: valueMetrics.text
            font.family: regularDosis.name
            font.pixelSize: fontSize
            color: textColor
        }
    }

}