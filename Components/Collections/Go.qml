import QtQuick 2.15
import QtQuick.Layouts 1.15

import "../.."

RowLayout {
    // width: iconMetrics.width + valueMetrics.width
    // height: iconMetrics.height > valueMetrics.height ? iconMetrics.height : valueMetrics.height

    TextMetrics {
        id: iconMetrics
        text: "\uf1df"
        font {
            family: googleMaterial.name
            pixelSize: vpx(80)
        }
    }

    TextMetrics {
        id: valueMetrics
        text: "GO"
        font {
            family: regularDosis.name
            pixelSize: vpx(76)
            styleName: "SemiBold"
        }
    }

    Text {
        id: icon
        text: iconMetrics.text
        font: iconMetrics.font
        color: Consoles.primaryColor(currentCollection.shortName)
        Layout.alignment: Qt.AlignBottom
    }

    Text {
        id: value
        text: valueMetrics.text
        font: valueMetrics.font
        color: Consoles.primaryColor(currentCollection.shortName)
        Layout.bottomMargin: -vpx(5)
    }
}