import QtQuick 2.15
import QtQuick.Layouts 1.15

import "../../collectionsData.js" as CollectionsData

FocusScope {
    id: root

    readonly property var collectionData: CollectionsData.get[collections[currentCollectionIndex].shortName] || ""

    focus: true

    anchors.fill: parent

    /* Top Division */
    Item {
        id: top
        height: parent.height * 0.3
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
    }

    // /* Collection release year */
    // Text {
    //     anchors {
    //         bottom: center.top
    //         bottomMargin: -vpx(40)
    //     }
    //     text: api.collections.get(currentCollectionIndex).extra.year
    //     // text: "hello"
    //     font.family: regularDosis.name
    //     font.styleName: "Bold"
    //     font.pixelSize: vpx(120)
    //     color: collectionData.color
    // }

    /* Collections */
    // Item {
    //     id: center

    //     height: parent.height * 0.6
    //     anchors {
    //         left: parent.left
    //         right: parent.right
    //         top: top.bottom
    //     }

    //     ListView {
    //         id: listCollections

    //         anchors.fill: parent

    //         focus: true
    //         clip: false
    //         displayMarginBeginning: root.width
    //         displayMarginEnd: root.width

    //         model: collections
    //         delegate: CollectionsDelegate {}

    //         currentIndex: currentCollectionIndex

    //         Component.onCompleted: {
    //             positionViewAtIndex(currentIndex, ListView.Beginning)
    //         }

    //         onCurrentIndexChanged: {
    //             positionViewAtIndex(currentIndex, ListView.Beginning)
    //         }

    //         interactive: false

    //         orientation: ListView.Horizontal
    //         highlightRangeMode: ListView.StrictlyEnforceRange

    //         highlightMoveDuration: 0
    //         snapMode: ListView.SnapToItem

    //         Keys.onPressed: {
    //             if (event.isAutoRepeat) {
    //                 return
    //             }

    //             if (event.key == Qt.Key_Left) {
    //                 event.accepted = true
    //                 prevCollection()
    //             }

    //             if (event.key == Qt.Key_Right) {
    //                 event.accepted = true
    //                 nextCollection()
    //             }
    //         }

    //     }
    // }


    // // DEBUGGER
    // Rectangle {
    //     anchors.fill: center
    //     color: "yellow"
    //     opacity: 0.2
    // }


    // /* Collection logo */
    // Image {
    //     id: logo
    //     width: vpx(300)
    //     height: vpx(200)
    //     sourceSize.width: width
    //     sourceSize.height: height

    //     anchors {
    //         bottom: top.bottom
    //         left: top.left
    //         leftMargin: top.width / 2.2
    //     }
    //     source: "../../assets/collections/logo/"+api.collections.get(currentCollectionIndex).shortName+".png"
    //     fillMode: Image.PreserveAspectFit
    //     verticalAlignment: Image.AlignBottom
    //     mipmap: true
    // }

    // Rectangle {
    //     width: root.width * 0.57
    //     height: center.height * 0.35

    //     anchors {
    //         right: root.right
    //         bottom: center.top
    //         bottomMargin: - (parent.height * 0.04)
    //     }

    //     color: "yellow"

    //     Rectangle {
    //         id: collectionName

    //         width: parent.width * 0.7
    //         height: parent.height

    //         color: "blue"
    //     }

    //     Rectangle {
    //         id: collectionGamesCount

    //         width: parent.width * 0.3
    //         height: parent.height
    //         anchors.right: parent.right

    //         color: "green"

    //         /* Number of games in the collection with border outisde */
    //         CountGames {
    //             anchors {
    //                 right: parent.right
    //                 bottom: parent.bottom
    //             }
    //             xMargins: vpx(12)
    //             yMargins: vpx(5)
    //             count: collections[currentCollectionIndex].games.count
    //         }

    //     }

    // }

    // Item {
    //     id: collectionName
    //     width: vpx(450)
    //     height: vpx(100)
    //     anchors {
    //         left: root.left
    //         leftMargin: root.width * 0.45
    //         bottom: center.top
    //         bottomMargin: -vpx(15)
    //     }

    //     Rectangle {
    //         anchors.fill: parent
    //         color: "blue"
    //         opacity: 0.2
    //     }

    //     Text {
    //         width: parent.width
    //         height: parent.height
    //         anchors.baseline: parent.bottom
    //         text: collections[currentCollectionIndex].name
    //         font.family: boldDosis.name
    //         font.styleName: "Bold"

    //         fontSizeMode: Text.Fit
    //         minimumPixelSize: vpx(5)
    //         font.pixelSize: vpx(200)

    //         color: Qt.rgba(0.1, 0.1, 0.1)
    //     }
    // }


    // /* 45deg skewed rectangle/separator */
    // Rectangle {
    //     width: logo.width * 0.4
    //     height: vpx(7)

    //     anchors {
    //         top: logo.bottom
    //         topMargin: vpx(10)
    //         left: logo.left
    //     }

    //     color: "white"
    //     transform: Matrix4x4 {
    //         property real a: 45 * Math.PI / 180
    //         matrix: Qt.matrix4x4(
    //             1,      -Math.tan(a),       0,      0,
    //             0,      1,                  0,      0,
    //             0,      0,                  1,      0,
    //             0,      0,                  0,      1
    //         )
    //     }
    // }

    // /* Number of games info */
    // Rectangle {
    //     anchors {
    //         right: top.right
    //         bottom: logo.bottom
    //     }
    //     width: nbGames.width + vpx(10)
    //     height: nbGames.height + vpx(5)
    //     color: "transparent"
    //     border.color: "black"
    //     border.width: vpx(1)

    //     RowLayout {
    //         id: nbGames
    //         anchors.centerIn: parent
    //         spacing: vpx(10)

    //         Text {
    //             text: "\ue0b8"
    //             font.family: googleMaterial.name
    //             font.pixelSize: vpx(22)
    //             color: "black"
    //         }

    //         Text {
    //             text: api.collections.get(currentCollectionIndex).games.count+" games"
    //             font.family: regularDosis.name
    //             font.pixelSize: vpx(22)
    //             color: "black"
    //         }
    //     }

    // }

    // /* Manufacturer logo */
    // /* REPLACE BY IMAGE */
    // Text {
    //     anchors {
    //         bottom: center.bottom
    //         bottomMargin: - contentHeight / 2
    //         left: center.left
    //         leftMargin: vpx(15)
    //     }

    //     text: collectionData.manufacturer
    //     font.family: regularDosis.name
    //     font.styleName: "Bold"
    //     font.pixelSize: vpx(54)
    //     color: "grey"

    //     visible: collectionData.manufacturer
    // }

    /* Helper nav */
    // Item {
    //     id: bottom
    //     height: parent.height * 0.1
    //     anchors {
    //         left: parent.left
    //         right: parent.right
    //         top: center.bottom
    //     }

    //     Rectangle {
    //         anchors {
    //             left: parent.left
    //             right: parent.right
    //             bottom: parent.bottom
    //             bottomMargin: vpx(10)
    //         }
    //         height: vpx(2)
    //         color: "silver"

    //         Rectangle {
    //             id: navBar
    //             x: width * currentCollectionIndex
    //             width: parent.width / center.count
    //             height: parent.height
    //             color: collectionData.color || "grey"
    //         }

    //         Text {
    //             anchors {
    //                 bottom: navBar.top
    //                 horizontalCenter: navBar.horizontalCenter
    //             }
    //             text: (currentCollectionIndex + 1)+"/"+listCollections.count
    //             font.family: regularDosis.name
    //             font.styleName: "Medium"
    //             font.pixelSize: vpx(18)
    //             color: "black"
    //         }

    //     }

    // }

}