import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 5.15
import QtGraphicalEffects 1.15

import "../.."
import "../Global"

Item {
    id: root

    width: {
        let ratioValues = Variables.chooseHomeRatioCards.value.split(":")
        return height * (ratioValues[0] / ratioValues[1])
    }
    Behavior on width {
        NumberAnimation { duration: 300 }
    }
    height: __lv.height

    Rectangle {
        id: rect
        anchors.centerIn: assetItem
        width: assetItem.width + vpx(15)
        height: assetItem.height + vpx(15)
        color: "white"
        opacity: __isCurrentItem && __isActiveFocus ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 200 } }
    }

    ColumnLayout {
        id: assetItem

        width: parent.width
        height: parent.height

        Item {
            id: asset

            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height * 0.92

            // Fallback colored rectangle
            Rectangle {
                anchors.fill: parent
                color: "#BEBEBE"

                // Image missing icon
                Text {
                    text: "\uf022"
                    font {
                        family: googleMaterial.name
                        pixelSize: parent.height * 0.7
                    }
                    color: "#8A8A8A"
                    anchors.centerIn: parent
                    visible: assetPrimary.width == 0
                }
            }

            // BoxArt or Screenshot
            Image {
                id: assetPrimary
                visible: false
                asynchronous: true

                anchors.fill: parent
                sourceSize.height: height
                mipmap: true

                source: modelData.assets.screenshot || modelData.assets.background

                fillMode: Image.PreserveAspectCrop
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
            }

        }

        /* Game title */
        Text {
            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height * 0.08

            text: modelData.title
            font {
                family: fontSans.name
                pixelSize: vpx(16)
            }
            antialiasing: true
            maximumLineCount: 1
            wrapMode: Text.Wrap
            elide: Text.ElideRight
            horizontalAlignment: Text.AlignHCenter
            color: "black"
            opacity: __isCurrentItem && __isActiveFocus ? 1 : 0
            Behavior on opacity { NumberAnimation { duration: 200 } }
        }
    }

    // Bookmark added icon
    Text {
        height: play.height
        text: "\ue90a"
        font {
            family: googleMaterial.name
            pixelSize: play.height * 0.8
        }
        color: "#E34A68"
        anchors {
            top: rect.bottom
            left: rect.left
        }
        verticalAlignment: Text.AlignBottom
        opacity: __isCurrentItem && __isActiveFocus && modelData.favorite
        Behavior on opacity { NumberAnimation { duration: 200 } }
    }

    /* Play button */
    LaunchButton {
        id: play
        label: "PLAY"
        size: vpx(16)
        focused: __isActiveFocus
        anchors {
            top: rect.bottom
            right: rect.right
        }
    }

}