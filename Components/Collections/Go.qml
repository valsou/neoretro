import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    readonly property int fontSize: vpx(57)

    width: iconMetrics.width + valueMetrics.width
    height: iconMetrics.height > valueMetrics.height ? iconMetrics.height : valueMetrics.height



    // Rectangle {
    //     anchors.fill: parent
    //     color: "yellow"
    //     opacity: 0.4
    // }

    TextMetrics {
        id: iconMetrics
        text: "\uf1df"
        font {
            family: googleMaterial.name
            pixelSize: fontSize
        }
    }

    TextMetrics {
        id: valueMetrics
        text: "GO"
        font {
            family: regularDosis.name
            pixelSize: fontSize
            styleName: "SemiBold"
        }
    }

    RowLayout {
        anchors.centerIn: parent

        Layout.margins: vpx(10)

        Text {
            id: icon
            text: iconMetrics.text
            font: iconMetrics.font
            color: textColor
        }

        Text {
            id: value
            text: valueMetrics.text
            font: valueMetrics.font
            color: textColor
        }
    }
}