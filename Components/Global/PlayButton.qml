import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {

    readonly property int xMargins: vpx(12)
    readonly property int yMargins: vpx(1)
    readonly property int fontSize: vpx(18)

    width: iconMetrics.width + valueMetrics.width + xMargins * 2
    height: iconMetrics.height > valueMetrics.height ? iconMetrics.height + yMargins * 2 : valueMetrics.height + yMargins * 2

    color: "green"

    Behavior on width {
        PropertyAnimation { properties: "width"; easing.type: Easing.InOutQuad }
    }

    TextMetrics {
        id: iconMetrics
        text: "\ue037"
        font {
            family: googleMaterial.name
            pixelSize: fontSize
        }
    }

    TextMetrics {
        id: valueMetrics
        text: "PLAY"
        font {
            family: regularDosis.name
            pixelSize: fontSize
            styleName: "SemiBold"
        }
    }

    RowLayout {
        anchors.centerIn: parent

        // Layout.margins: vpx(1)

        Text {
            id: icon
            text: iconMetrics.text
            font: iconMetrics.font
            color: "white"
        }

        Text {
            id: value
            text: valueMetrics.text
            font: valueMetrics.font
            color: "white"
        }
    }

}