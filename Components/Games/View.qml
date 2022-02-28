import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.12

import "../../collectionsData.js" as CollectionsData

FocusScope {
    id: root

    readonly property var collectionData: CollectionsData.get[collections[currentCollectionIndex].shortName] || ""
    readonly property var alphabet: ["#", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    readonly property int currentAlphabetIndex: getAlphabetIndex(getAlphabetFirstChar(currentGameIndex))

    //
    property int down: 0

    focus: true

    anchors.fill: parent

    function getAlphabetFirstChar(currentGameIndex) {
        return collections[currentCollectionIndex].games.get(currentGameIndex).title[0].toUpperCase()
    }

    function getAlphabetIndex(letter) {
        const regex = /[A-Z]/g
        if (letter.match(regex)) {
            return alphabet.indexOf(letter)
        }
        else {
            return 0
        }
    }

    Item {
        id: helperCollectionName
        width: parent.width
        height: parent.height * 0.1

        Image {
            id: manufacturerLogo
            width: parent.width
            height: parent.height * 0.6
            anchors {
                verticalCenter: parent.verticalCenter
            }
            sourceSize.width: width
            source: darkTheme   ? "../../assets/collections/logo/"+collections[currentCollectionIndex].shortName+".png"
                                : "../../assets/collections/logo/"+collections[currentCollectionIndex].shortName+".png"
            fillMode: Image.PreserveAspectFit
            horizontalAlignment: Image.AlignLeft
            mipmap: true

        }

        Text {
            width: parent.width
            height: parent.height * 0.8
            anchors.verticalCenter: parent.verticalCenter
            text: collections[currentCollectionIndex].name
            color: textColor
            fontSizeMode: Text.Fit
            minimumPixelSize: vpx(5)
            font {
                family: regularDosis.name
                styleName: "SemiBold"
                pixelSize: vpx(200)
            }
            visible: manufacturerLogo.status !== Image.Ready
        }
    }

    /* Game Details */
    // GameDetails {
    //     id: gameDetails
    //     width: parent.width
    //     visible: true
    //     height: visible ? parent.height * 0.4 : 0
    //     anchors {
    //         top: helperCollectionName.bottom
    //     }
    // }
    // Loader {
    //     id: gameDetails

    //     width: parent.width
    //     height: visible ? parent.height * 0.4 : 0
    //     anchors {
    //         top: helperCollectionName.bottom
    //     }

    //     sourceComponent: GameDetails {}

    //     asynchronous: true
    //     visible: contentLoader.status === Loader.Ready ? 1 : 0
    //     opacity: visible
    //     Behavior on opacity { OpacityAnimator { duration: 300 } }
    //     active: true
    // }

    /* Grid */
    GridView {
        id: gamesList

        readonly property int columnSpacing: vpx(20)
        readonly property int rowSpacing: vpx(45)

        width: parent.width + columnSpacing
        height: parent.height * 1.1
        anchors {
            horizontalCenter: root.horizontalCenter
            top: helperCollectionName.bottom
            topMargin: gameDetails.height
        }

        cellWidth: width / gridColumns
        cellHeight: height / gridRows

        highlightFollowsCurrentItem: true
        highlightRangeMode: GridView.StrictlyEnforceRange

        focus: true
        clip: true

        currentIndex: currentGameIndex
        onCurrentIndexChanged: {
            currentGameIndex = currentIndex
        }

        snapMode: ListView.SnapToItem
        model: collections[currentCollectionIndex].games

        delegate: GamesDelegate {}

        Keys.onLeftPressed: {
            // Disable left nav that goes to currentIndex - 1
            if ((currentIndex % gridColumns) === 0) {
                event.accepted = true
            }
            else {
                event.accepted = false
            }
        }

        Keys.onRightPressed: {
            // Disable right nav that goes to currentIndex + 1
            if (((currentIndex % gridColumns) === (gridColumns - 1)) || (currentIndex === count - 1)) {
                event.accepted = true
            }
            else {
                event.accepted = false
            }
        }

        Keys.onDownPressed: {
            // Go to last item if no item below
            if (currentIndex + gridColumns >= count &&
                count - gridColumns >= gridColumns - 1 &&
                count % gridColumns != 0) {
                event.accepted = true
                currentIndex = count - 1
                down++
            }
            else {
                event.accepted = false
            }
        }

        Keys.onPressed: {
            if (api.keys.isDetails(event)) {
                event.accepted = true
                gameDetails.visible = !gameDetails.visible
            }
        }
    }

    Rectangle {
        width: vpx(4)
        height: parent.height * 0.7
        anchors {
            top: parent.top
            topMargin: vpx(22)
            left: gamesList.right
        }
        color: Qt.rgba(textColor.r, textColor.g, textColor.b, 0.1)

        Rectangle {
            y: (parent.height + height) / gamesList.count * gamesList.currentIndex
            width: parent.width
            height: vpx(25)
            color: Qt.rgba(textColor.r, textColor.g, textColor.b, 0.2)

            Behavior on y {
                NumberAnimation { duration: 100 }
            }
        }
    }

    ListView {
        id: helperAlphabet
        width: vpx(30)
        height: parent.height * 0.7

        interactive: false
        focus: false
        opacity: focus ? 1 : 0.5

        anchors {
            top: parent.top
            topMargin: vpx(22)
            right: root.right
            rightMargin: -vpx(75)
        }
        model: alphabet
        delegate: Text {
            color: "red"
            text: modelData
            enabled: modelData == "C" ? false : true
        }
        highlight: Rectangle {
            color: "black"
        }

        currentIndex: currentAlphabetIndex

        // Keys.onLeftPressed: {
        //     event.accepted = true
        //     gamesList.focus = true
        //     focus = false
        // }

        Keys.onUpPressed: {
            if (currentIndex == 0) {
                event.accepted = true
            }
            else {
                event.accepted = false
            }
        }
    }

    Text {
        text: "No games here."
        anchors.centerIn: parent
        visible: gamesList.count == 0
    }

    Text {
        anchors {
            top: parent.top
            right: parent.right
        }
        text: "Game index : "+currentGameIndex+"\nDOWN : "+down+"\nGames count : "+gamesList.count
        color: "red"
    }

    Keys.onPressed: {
        if (api.keys.isPageDown(event)) {
            event.accepted = true
            prevCollection()
        }
        if (api.keys.isPageUp(event)) {
            event.accepted = true
            nextCollection()
        }
    }
}