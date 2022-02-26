import QtQuick 2.15
import QtGraphicalEffects 1.15

import "../blurHashes.js" as BlurHashes

Rectangle {
    id: root

    readonly property var blurHashBackground: BlurHashes.blurHashCollections[collections[currentCollectionIndex].shortName] || BlurHashes.blurHashCollections["default"]

    anchors.fill: parent

    color: backgroundColor

    Image {
        id: background

        anchors.fill: parent

        asynchronous: true

        source: "../assets/collections/art/"+collections[currentCollectionIndex].shortName+".jpg"
        sourceSize.width: width
        sourceSize.height: height
        fillMode: Image.PreserveAspectCrop
        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignVCenter
        visible: false
    }

    FastBlur {
        anchors.fill: background
        source: background
        radius: 64
        visible: (background.status == Image.Ready)
        opacity: visible ? 0.2 : 0
        Behavior on opacity { OpacityAnimator { duration: 600 } }
    }

    Image {
        id: fallbackBackground
        anchors.fill: parent
        source: "image://blurhash/"+encodeURIComponent(blurHashBackground)
        fillMode: Image.PreserveAspectCrop
        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignVCenter
        visible: (background.status != Image.Ready)
        opacity: visible ? 0.2 : 0
    }

}