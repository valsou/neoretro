import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 5.15
import QtGraphicalEffects 1.15

Item {
    id: root

    readonly property ListView __games: ListView.view
    readonly property bool __isActiveFocus: activeFocus
    readonly property bool __isCurrentItem: ListView.isCurrentItem

    property int fallbackWidth: {
        var ratioValues = chooseHomeRatioCards.split(":")
        var ratio = ratioValues[0] / ratioValues[1]
        return height * ratio
    }

    width: asset.width
    Behavior on width {
        NumberAnimation { duration: 300 }
    }
    height: __games.height

    scale: __isCurrentItem && __isActiveFocus ? 1 : 0.9
    Behavior on scale {
        NumberAnimation { duration: 200 }
    }

    Item {
        id: asset

        anchors {
            centerIn: parent
        }
        width: {
            if (chooseHomeTypeOfAssets == "boxArt" && assetPrimary.width) {
                return assetPrimary.width
            }
            else {
                var ratioValues = chooseHomeRatioCards.split(":")
                var ratio = ratioValues[0] / ratioValues[1]
                return height * ratio
            }
        }
        height: parent.height

        Text {
            text: "\ueb8b"
            font {
                family: googleMaterial.name
                pixelSize: parent.height * 0.7
            }
            color: "silver"
            anchors.centerIn: parent
            visible: assetPrimary.width == 0
        }

        // BoxArt or Screenshot
        Image {
            id: assetPrimary
            visible: false
            asynchronous: true
            anchors.fill: {
                if (chooseHomeTypeOfAssets == "screenshot+logo") {
                    return parent
                }
            }
            height: parent.height
            sourceSize.height: height

            source: {
                if (chooseHomeTypeOfAssets == "boxArt") {
                    return modelData.assets.boxFront
                }
                return modelData.assets.screenshot
            }

            fillMode: {
                if (chooseHomeTypeOfAssets == "boxArt") {
                    return Image.PreserveAspectFit
                }
                return Image.PreserveAspectCrop
            }
        }

        Desaturate {
            anchors.fill: assetPrimary
            source: assetPrimary
            desaturation: __isCurrentItem && __isActiveFocus ? 0 : 1.0
            Behavior on desaturation { NumberAnimation { duration: 200 } }
        }

        // Logo
        Image {
            id: assetLogo
            asynchronous: true
            anchors.fill: parent
            source: modelData.assets.logo
            fillMode: Image.PreserveAspectFit
            scale: __isCurrentItem ? 0.75 : 0.6
            Behavior on scale { NumberAnimation { duration: 200 } }
            mipmap: true
            visible: chooseHomeTypeOfAssets == "screenshot+logo"
        }



        // Border on selection
        Rectangle {
            anchors.fill: parent
            visible: __isCurrentItem && __isActiveFocus
            color: "transparent"
            border {
                width: vpx(1)
                color: "black"
            }
        }

    }

    LaunchButton {
        opacity: __isCurrentItem && __isActiveFocus
        label: "PLAY"
        scale: 0.8
        anchors {
            bottom: asset.top
            right: asset.right
        }
    }

    LikedLabel {
        visible: modelData.favorite
        scale: 0.7
        anchors {
            top: asset.top
            topMargin: height / -2
            left: asset.left
            leftMargin: vpx(8)
        }
    }

    /* Game title */
    Text {
        width: root.width
        anchors {
            top: asset.bottom
            topMargin: vpx(5)
        }
        text: modelData.title
        font {
            family: fontSans.name
            pixelSize: vpx(16)
            weight: Font.DemiBold
        }
        antialiasing: true
        maximumLineCount: 2
        wrapMode: Text.Wrap
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter
        color: "black"

        // layer.enabled: true
        // layer.effect: DropShadow {
        //     color: "#99FFFFFF"
        //     radius: 6
        //     samples: 12
        //     spread: 0
        // }
    }

}