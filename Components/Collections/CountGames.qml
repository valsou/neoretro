import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    property int count: 0
    property int xMargins: 0
    property int yMargins: 0


    width: iconMetrics.width + valueMetrics.width + xMargins * 2
    height: iconMetrics.height > valueMetrics.height ? iconMetrics.height + yMargins * 2 : valueMetrics.height + yMargins * 2

    color: "transparent"
    border {
        width: vpx(1)
        color: textColor
    }

    TextMetrics {
        id: iconMetrics
        text: "\ue0b8"
        font.family: googleMaterial.name
        font.pixelSize: vpx(24)
    }

    TextMetrics {
        id: valueMetrics
        text: count+" games"
        font.family: regularDosis.name
        font.pixelSize: vpx(24)
    }

    RowLayout {
        anchors.centerIn: parent

        Layout.margins: vpx(10)

        Text {
            id: icon
            text: iconMetrics.text
            font.family: googleMaterial.name
            font.pixelSize: vpx(24)
        }

        Text {
            id: value
            text: valueMetrics.text
            font.family: regularDosis.name
            font.pixelSize: vpx(24)
        }
    }

}