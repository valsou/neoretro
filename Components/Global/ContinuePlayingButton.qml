import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {

    width: childrenRect.width * 1.15
    height: childrenRect.height * 1.1

    color: "green"

    Behavior on width {
        PropertyAnimation { properties: "width"; easing.type: Easing.InOutQuad }
    }

    RowLayout {
        anchors.centerIn: parent

        spacing: vpx(5)

        Text {
            Layout.alignment: Qt.AlignVCenter
            text: value.text
            font: value.font
            color: "white"

            TextMetrics {
                id: value
                text: "RESUME PLAYING"
                font {
                    family: regularDosis.name
                    pixelSize: vpx(18)
                    styleName: "SemiBold"
                }
            }
        }
    }

}