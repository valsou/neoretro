import QtQuick 2.15

Item {
    property bool loading: false
    property int size: 0
    property int countPoints: 0

    Text {
        id: loadingText
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        text: "Loading"
        font {
            family: regularDosis.name
            styleName: "SemiBold"
            pixelSize: vpx(200)
        }
        minimumPixelSize: vpx(5)
        fontSizeMode: Text.Fit
        color: textColor
        opacity: 0.5
    }

    Timer {
        id: timer
        interval: 100
        repeat: true
        running: loading
        triggeredOnStart: true
        onTriggered: {
            if (countPoints > 6) {
                loadingText.text = "Loading"
                countPoints = 0
            }
            loadingText.text += "."
            countPoints++
        }
    }

}