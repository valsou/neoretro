import QtQuick 2.15
import QtGraphicalEffects 1.15

import "../../blurHashes.js" as BlurHashes

Item {
    id: root

    readonly property bool __isCurrentItem: ListView.isCurrentItem
    readonly property ListView __lv: ListView.view
    readonly property var blurHashBackground: BlurHashes.blurHashCollections[modelData.shortName] || BlurHashes.blurHashCollections["default"]

    width: __isCurrentItem ? __lv.width * 0.5 : __lv.width * 0.3
    height: __lv.height

    clip: false

    Item {
        width: parent.width
        height: __isCurrentItem ? parent.height: parent.height * 0.5

        anchors.bottom: parent.bottom

        opacity: __isCurrentItem ? 1 : 0.2

        Rectangle {
            anchors.fill: parent
            color: backgroundColor
        }

        Image {
            id: cardBackground
            anchors.fill: parent
            source:     "../../assets/collections/art/"+modelData.shortName+".jpg"
                    ||  "image://blurhash/" + encodeURIComponent(BlurHashes.blurHashCollections[modelData.shortName])
            fillMode: Image.PreserveAspectCrop
            visible: (__isCurrentItem)
        }

        Colorize {
            anchors.fill: cardBackground
            source: cardBackground
            hue: 0.0
            saturation: 0.0
            lightness: 0.0
            visible: (__isCurrentItem == false)
        }

        // // DEBUGGER
        // Rectangle {
        //     anchors.fill: parent
        //     color: Qt.rgba(255,0,0,0.2)
        //     border {
        //         width: vpx(1)
        //         color: "red"
        //     }
        // }
    }
}