import QtQuick 2.15
import QtQuick.Layouts 1.15

/* Time (hh:ss) display */

RowLayout {

    // TextMetrics {
    //     id: iconMetrics
    //     text: "\ue8b5"
    //     font {
    //         family: googleMaterial.name
    //         pixelSize: vpx(20)
    //     }
    // }

    TextMetrics {
        id: valueMetrics
        text: Qt.formatTime(new Date(), "hh:mm")
        font {
            family: fontSans.name
            pixelSize: vpx(26)
        }
    }

    // Text {
    //     id: textTimeIcon

    //     text: iconMetrics.text
    //     font: iconMetrics.font
    //     color: Qt.rgba(0.3, 0.3, 0.3)

    //     // Layout.alignment: Qt.AlignVCenter
    //     Layout.bottomMargin: -vpx(4)
    // }

    Text {
        id: textTime

        text: valueMetrics.text
        font: valueMetrics.font
        color: Qt.rgba(0.3, 0.3, 0.3)

        // Layout.alignment: Qt.AlignVCenter
        // Layout.bottomMargin: -vpx(6)
    }

    Timer {
        id: timer
        interval: 10000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: valueMetrics.text=Qt.formatTime(new Date(), "hh:mm")
    }
}