import QtQuick 2.15
import QtGraphicalEffects 1.15

import "../blurHashes.js" as BlurHashes

Rectangle {
    id: root

    readonly property var blurHashBackground: BlurHashes.blurHashCollections[collections[currentCollectionIndex].shortName] || BlurHashes.blurHashCollections["default"]
    readonly property real variableOpacity: darkTheme ? 0.25 : 0.4

    anchors.fill: parent

    color: backgroundColor

    Image {
        id: background

        anchors.fill: parent

        asynchronous: true

        source: currentPageIndex == 3 ? currentGame.assets.screenshot :
                "../assets/collections/art/"+collections[currentCollectionIndex].shortName+".jpg"
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
        radius: 96
        visible: (background.status == Image.Ready)
        opacity: visible ? variableOpacity : 0
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
        opacity: visible ? variableOpacity : 0
    }

    // Gradient behind top bar
    Rectangle {
        width: root.width
        height: root.height * 0.3
        anchors.top: root.top

        gradient: Gradient {
            GradientStop { position: 0.0; color: backgroundColor }
            GradientStop { position: 1.0; color: "transparent" }
        }
    }

}