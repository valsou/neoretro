import QtQuick 2.15
import QtQuick.Layouts 1.15

/* Time (hh:ss) display */
Item {
    id: root

    implicitWidth: textTime.width + textTimeIcon.width + vpx(6)
    implicitHeight: textTime.height

    Text {
        id: textTimeIcon
        anchors.right: textTime.left
        anchors.rightMargin: vpx(6)
        anchors.bottom: textTime.baseline

        text: "\ue8b5"
        font.family: googleMaterial.name
        color: textColor
        font.pixelSize: vpx(20)
    }

    Text {
        id: textTime
        anchors.baseline: root.bottom
        anchors.right: root.right
        font.family: regularDosis.name
        color: textColor
        text: Qt.formatTime(new Date(), "hh:mm")
        font.pixelSize: vpx(26)
    }

    Timer {
       id: timer
       interval: 10000
       repeat: true
       running: true
       triggeredOnStart: true
       onTriggered: textTime.text=Qt.formatTime(new Date(), "hh:mm")
   }

    // Debugger Rectangle
    // Rectangle {
    //     anchors.fill: root
    //     color: "red"
    //     opacity: 0.7
    // }

}