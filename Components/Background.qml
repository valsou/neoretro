import QtQuick 2.15
import QtGraphicalEffects 1.15

import ".."
import "../blurHashes.js" as BlurHashes

Rectangle {
    id: root

    property alias colorTouchAnimation: colorTouchAnimation
    property bool pageFocused
    readonly property var blurHashBackground: BlurHashes.blurHashCollections[collections[currentCollectionIndex].shortName] || BlurHashes.blurHashCollections["default"]
    readonly property real variableOpacity: enableDarkTheme ? 0.25 : 0.4
    readonly property var gradientBegin: pagesModelProxy[currentPageIndex].bgColorBegin || "black"
    readonly property var gradientEnd: pagesModelProxy[currentPageIndex].bgColorEnd || "black"

    anchors.fill: parent

    color: "#ECECEC"

    Rectangle {
        id: colorTouch
        width: parent.width * 1.2
        height: (pagesHeight * pagesModel[currentPageIndex].heightSize) * 0.75
        anchors {
            top: root.top
            topMargin: headerHeight * 2
            horizontalCenter: parent.horizontalCenter
        }
        rotation: pagesModel[currentPageIndex].bgAngle
        antialiasing: true
        // color: "transparent"
        opacity: (currentPageIndex !== pagesModelProxy.length - 1) & pageFocused
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0.0; color: gradientBegin }
            GradientStop { position: 1.0; color: gradientEnd }
        }
    }

    SequentialAnimation {
        id: colorTouchAnimation
        running: true
        NumberAnimation { target: colorTouch; property: "width"; from: 0; to: parent.width * 1.2; duration: 200 }
    }

    // Item {
    //     anchors.fill: parent

    //     Image {
    //         id: background

    //         anchors.fill: parent

    //         asynchronous: true

    //         source: currentMenuIndex == 2 ? currentGame.assets.screenshot :
    //                 "../assets/collections/art/"+collections[currentCollectionIndex].shortName+".jpg"
    //         sourceSize.width: width
    //         sourceSize.height: height
    //         fillMode: Image.PreserveAspectCrop
    //         horizontalAlignment: Image.AlignHCenter
    //         verticalAlignment: Image.AlignVCenter
    //         visible: false
    //     }

    //     FastBlur {
    //         id: blurredBackground
    //         anchors.fill: background
    //         source: background
    //         radius: 96
    //         visible: (background.status == Image.Ready)
    //         opacity: visible ? variableOpacity : 0
    //         Behavior on opacity { OpacityAnimator { duration: 600 } }
    //     }

    //     Image {
    //         id: fallbackBackground
    //         anchors.fill: parent
    //         source: "image://blurhash/"+encodeURIComponent(blurHashBackground)
    //         fillMode: Image.PreserveAspectCrop
    //         horizontalAlignment: Image.AlignHCenter
    //         verticalAlignment: Image.AlignVCenter
    //         visible: (background.status != Image.Ready)
    //         opacity: visible ? variableOpacity : 0
    //     }
    // }


    // // Test rectangle skewed randomized
    // Rectangle {
    //     id: test
    //     anchors.centerIn: root
    //     width: root.width * 1.1
    //     height: root.height * 0.52
    //     color: "white"
    //     antialiasing: true
    //     rotation: skewAngle
    //     opacity: 0.3

    //     Behavior on rotation {
    //         NumberAnimation { duration: 200 }
    //     }
    // }

    /* Noise */
    Image {
        anchors.fill: parent
        source: "../assets/noise.jpg"
        fillMode: Image.Tile
        opacity: 0.2
    }

}