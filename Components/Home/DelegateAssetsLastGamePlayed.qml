import QtQuick 2.15
import QtMultimedia 5.15
import QtGraphicalEffects 1.15

Item {
    property alias video: video
    readonly property ListView __lv: ListView.view
    readonly property bool __isActiveFocus: activeFocus

    width: __lv.width
    height: __lv.height

    Image {
        id: image
        width: modelData.type == "logo" ? parent.width * 0.8 : parent.width
        height: modelData.type == "logo" ? parent.height * 0.6 : parent.height
        anchors {
            centerIn: parent
        }
        source: {
            if (modelData.type == "background") {
                return modelData.assets.background
            }
            if (modelData.type == "screenshot") {
                return modelData.assets.screenshot
            }
            if (modelData.type == "logo") {
                return modelData.assets.logo
            }
            if (modelData.type == "titlescreen") {
                return modelData.assets.titlescreen
            }
            return ""
        }
        fillMode: {
            if (modelData.type == "logo") {
                return Image.PreserveAspectFit
            }
            else {
                return Image.PreserveAspectCrop
            }
        }
        visible: (modelData.type !== "logo")
    }

    DropShadow {
        anchors.fill: image
        horizontalOffset: 3
        verticalOffset: 3
        radius: 6
        samples: 1 + (radius * 2)
        color: "#80000000"
        source: image
        visible: (modelData.type == "logo")
    }

    Video {
        id: video
        anchors.fill: parent
        fillMode: VideoOutput.PreserveAspectFit
        source: (modelData.type == "video") ? modelData.assets.video : ""
        autoPlay: false
        muted: true
        loops: MediaPlayer.Infinite
    }

    // Pause icon
    Text {
        anchors.centerIn: parent
        text: "\ue1a2"
        font {
            family: googleMaterial.name
            pixelSize: parent.height * 0.4
        }
        color: "white"
        opacity: 0.7
        visible: (modelData.type == "video") && (video.playbackState == MediaPlayer.PausedState)
    }

    // Sound muted icon
    Text {
        anchors {
            right: video.right
            rightMargin: vpx(10)
            top: video.top
            topMargin: vpx(10)
        }
        text: "\ue04f"
        font {
            family: googleMaterial.name
            pixelSize: parent.height * 0.12
        }
        color: "#F73729"
        visible: (modelData.type == "video") && video.muted
    }
}