import QtQuick 2.15

Rectangle {
    width: vpx(86)
    height: vpx(30)
    color: "crimson"

    Text {
        anchors.centerIn: parent
        text: "LIKED"
        font {
            family: fontSans.name
            weight: Font.ExtraBold
            pixelSize: vpx(20)
        }
        color: "white"
    }
}