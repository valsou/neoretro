import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 5.15

import "../Global"

FocusScope {
    id: root
    focus: true

    states: [
        // State { name: "filtering"; PropertyChanges { target: dropdownFiltering; focus: true } },
        State { name: "manufacturer"; PropertyChanges { target: manufacturerSelector; focus: true } },
        State { name: "sorting"; PropertyChanges { target: dropdownSorting; focus: true } },
        State { name: "grid"; PropertyChanges { target: gamesList; focus: true } }
    ]
    state: "grid"
    property var lastHeaderState: ""

    RowLayout {
        id: header

        z: 1
        width: parent.width
        height: parent.height * 0.08
        anchors.top: parent.top

        /* Collection nav */
        ManufacturerSelector {
            id: manufacturerSelector
            focus: false

            Layout.preferredWidth: parent.width * 0.25
            Layout.preferredHeight: parent.height
            Layout.alignment: Qt.AlignLeft

            Keys.onPressed: {
                if (api.keys.isAccept(event)) {
                    event.accepted = true
                    dropdownStatus = !dropdownStatus
                }

                if (api.keys.isCancel(event)) {
                    if (dropdownStatus) {
                        event.accepted = true
                        dropdownStatus = false
                    }
                    else {
                        event.accepted = false
                    }
                }
            }

            Keys.onRightPressed: {
                event.accepted = true
                root.state = "sorting"
                lastHeaderState = "sorting"
            }

            //=> Go back to Games grid
            Keys.onDownPressed: {
                event.accepted = true
                dropdownStatus = false
                root.state = "grid"
            }
        }

        /* Filter by */
        //=> TODO: filter by all kind of criteria with checkboxes.
        // DropdownFiltering {
        //     id: dropdownFiltering
        //     focus: false

        //     Layout.alignment: Qt.AlignRight | Qt.AlignBottom

        //     Keys.onPressed: {
        //         if (api.keys.isAccept(event)) {
        //             event.accepted = true
        //             dropdownStatus = !dropdownStatus
        //         }

        //         if (api.keys.isCancel(event)) {
        //             event.accepted = true
        //             dropdownStatus = false
        //         }
        //     }

        //     Keys.onRightPressed: {
        //         event.accepted = true
        //         root.state = "sorting"
        //         lastHeaderState = "sorting"
        //     }

        //     //=> Go back to Games grid
        //     Keys.onDownPressed: {
        //         event.accepted = true
        //         root.state = "grid"
        //     }
        // }

        /* Sorting by */
        // DropdownSorting {
        //     id: dropdownSorting
        //     focus: false

        //     Layout.alignment: Qt.AlignRight | Qt.AlignBottom

        //     Keys.onPressed: {
        //         if (api.keys.isAccept(event)) {
        //             event.accepted = true
        //             dropdownStatus = !dropdownStatus
        //         }

        //         if (api.keys.isCancel(event)) {
        //             if (dropdownStatus) {
        //                 event.accepted = true
        //                 dropdownStatus = false
        //             }
        //             else {
        //                 event.accepted = false
        //             }
        //         }
        //     }

        //     Keys.onLeftPressed: {
        //         event.accepted = true
        //         root.state = "manufacturer"
        //         lastHeaderState = "manufacturer"
        //     }

        //     //=> Go back to Games grid
        //     Keys.onDownPressed: {
        //         event.accepted = true
        //         root.state = "grid"
        //     }
        // }

    }

    Item {
        width: parent.width
        height: parent.height * 0.92
        anchors.bottom: parent.bottom

        Rectangle {
            id: gamesDetails
            anchors {
                top: parent.top
                right: (chooseDetailsViewLayout == "vertical") ? parent.right : ""
            }
            width: {
                if (enableDetailsView) {
                    if (chooseDetailsViewLayout == "horizontal") {
                        return parent.width
                    }
                    else {
                        // Vertical
                        return parent.width * 0.45
                    }
                }
                else {
                    return 0
                }
            }
            height: {
                if (enableDetailsView) {
                    if (chooseDetailsViewLayout == "horizontal") {
                        return parent.height * 0.45
                    }
                    else {
                        // Vertical
                        return parent.height
                    }
                }
                else {
                    return 0
                }
            }
            Behavior on height { NumberAnimation { duration: 150 } }
            color: "red"
        }

        // /* Game Details */
        // GameDetails {
        //     id: gameDetails
        //     width: parent.width
        //     visible: false
        //     height: visible ? parent.height * 0.4 : 0
        //     // anchors {
        //     //     top: helperCollectionName.bottom
        //     // }
        // }

        /* Grid */
        GridView {
            id: gamesList

            readonly property real ratio: {
                let ratio = ""
                if (chooseLibraryTypeOfAssets == "boxArt") {
                    ratio = currentCollection.boxFrontRatio || "1:1"
                }
                else {
                    ratio = chooseLibraryRatioCards
                }

                let ratioValues = ratio.split(":")

                return ratioValues[0] / ratioValues[1]
            }

            readonly property int columnSpacing: vpx(20) // still used ?
            readonly property int rowSpacing: vpx(45) // still used ?

            readonly property int textInfoHeight: enableLibraryBelowInfo ? vpx(42) : 0
            readonly property int margin: vpx(10)
            readonly property int assetWidth: cellWidth - (margin * 2)

            readonly property int columns: {
                if (enableDetailsView && chooseDetailsViewLayout == "vertical") {
                    if (gridNumberOfColumns <= 1) {
                        return 1
                    }
                    else {
                        return gridNumberOfColumns - 1
                    }
                }
                else {
                    return gridNumberOfColumns
                }
            }

            width: {
                if (enableDetailsView) {
                    if (chooseDetailsViewLayout == "horizontal") {
                        return parent.width
                    }
                    else {
                        // Vertical
                        return parent.width * 0.55
                    }
                }
                else {
                    return parent.width
                }
            }
            height: {
                if (enableDetailsView) {
                    if (chooseDetailsViewLayout == "horizontal") {
                        return parent.height * 0.55
                    }
                    else {
                        // Vertical
                        return parent.height
                    }
                }
                else {
                    return parent.height
                }
            }
            Behavior on height { NumberAnimation { duration: 150 } }
            anchors {
                top: (chooseDetailsViewLayout == "vertical") ? parent.top : gamesDetails.bottom
                left: (chooseDetailsViewLayout == "vertical") ? parent.left : ""
            }

            cellWidth: width / columns
            cellHeight: (margin * 2) + (assetWidth / ratio) + textInfoHeight

            highlightRangeMode: GridView.ApplyRange

            focus: false
            clip: true

            currentIndex: currentGameIndex
            onCurrentIndexChanged: {
                currentItem.videoTimer.running = true
                currentGameIndex = currentIndex
            }

            snapMode: ListView.SnapToItem
            model: proxyModel

            delegate: Item {

                readonly property real ratio: gamesList.ratio
                readonly property int margin: gamesList.margin
                readonly property int assetWidth: gamesList.assetWidth
                readonly property int textInfoHeight: gamesList.textInfoHeight
                readonly property GridView __gv: GridView.view
                readonly property bool __isActiveFocus: activeFocus
                readonly property bool __isCurrentItem: GridView.isCurrentItem

                property alias videoLoader: videoLoader
                property alias videoTimer: videoTimer

                width: __gv.cellWidth
                height: __gv.cellHeight

                Item {
                    width: assetWidth
                    height: (assetWidth / ratio) + textInfoHeight
                    anchors.centerIn: parent

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: vpx(5)

                        Rectangle {
                            opacity: (loaderDelegate.status == Loader.Loading)
                            Behavior on opacity { NumberAnimation { duration: 150 } }
                            Layout.preferredWidth: parent.width
                            Layout.fillHeight: true
                            color: "#D0D0D0"
                        }

                        Rectangle {
                            opacity: (loaderDelegate.status == Loader.Loading)
                            Behavior on opacity { NumberAnimation { duration: 150 } }
                            Layout.preferredWidth: parent.width
                            Layout.preferredHeight: textInfoHeight - vpx(5)
                            Layout.alignment: Qt.AlignHCenter
                            color: "#B2B2B2"
                        }
                    }
                }

                Loader {
                    id: loaderDelegate

                    anchors.fill: parent
                    asynchronous: true
                    sourceComponent: DelegateGames {}
                }

                // Video
                Item {
                    width: assetWidth
                    height: (assetWidth / ratio)
                    anchors {
                        top: parent.top
                        topMargin: margin
                        horizontalCenter: parent.horizontalCenter
                    }

                    Component {
                        id: videoComponent

                        Item {
                            anchors.fill: parent

                            Video {
                                id: video
                                anchors.fill: parent
                                source: modelData.assets.video
                                fillMode: VideoOutput.PreserveAspectCrop
                                autoPlay: true
                                muted: true
                                loops: 0
                            }
                        }
                    }

                    Timer {
                        id: videoTimer
                        running: false
                        repeat: false
                        interval: 1500
                        onTriggered: {
                            videoLoader.active = true
                        }
                    }

                    Loader {
                        id: videoLoader
                        anchors.fill: parent
                        asynchronous: true
                        active: false
                        sourceComponent: videoComponent
                    }
                }

            }

            highlight: Item {
                Rectangle {
                    anchors.fill: parent
                    color: "white"
                }
            }

            onActiveFocusChanged: {
                if (activeFocus) {
                    currentItem.videoTimer.running = true
                }
                else {
                    currentItem.videoTimer.running = false
                    currentItem.videoLoader.active = false
                }
            }

            Keys.onLeftPressed: {
                currentItem.videoTimer.running = false
                currentItem.videoLoader.active = false

                // Disable left nav that goes to currentIndex - 1
                if ((currentIndex % columns) === 0) {
                    event.accepted = true
                }
                else {
                    event.accepted = false
                }
            }

            Keys.onRightPressed: {
                currentItem.videoTimer.running = false
                currentItem.videoLoader.active = false

                // Disable right nav that goes to currentIndex + 1
                if (((currentIndex % columns) === (columns - 1)) || (currentIndex === count - 1)) {
                    event.accepted = true
                }
                else {
                    event.accepted = false
                }
            }

            Keys.onUpPressed: {
                currentItem.videoTimer.running = false
                currentItem.videoLoader.active = false

                if (currentIndex < columns) {
                    focus = false
                    root.state = lastHeaderState || "manufacturer"
                }
                else {
                    event.accepted = false
                }
            }

            Keys.onDownPressed: {
                currentItem.videoTimer.running = false
                currentItem.videoLoader.active = false

                // Go to last item if no item below
                if (currentIndex + columns >= count &&
                    count - columns >= columns - 1 &&
                    count % columns != 0) {
                    event.accepted = true
                    currentIndex = count - 1
                }
                else {
                    event.accepted = false
                }
            }

            Keys.onPressed: {
                if (api.keys.isAccept(event)) {
                    event.accepted = true
                    console.log(currentGame.title)
                    currentGame.launch()
                }

                if (api.keys.isDetails(event)) {
                    event.accepted = true
                    enableDetailsView = !enableDetailsView
                }
            }
        }
    }

    /* Counter rectangle */
    Rectangle {
        width: vpx(5)
        height: vpx(500)
        anchors {
            left: root.left
            leftMargin: -vpx(15)
        }

        color: Qt.rgba(textColor.r, textColor.g, textColor.b, 0.1)

        Rectangle {
            y: height * gamesList.currentIndex
            width: parent.width
            height: parent.height / gamesList.count
            color: Qt.rgba(textColor.r, textColor.g, textColor.b, 0.2)

            Behavior on y {
                NumberAnimation { duration: 100 }
            }
        }
    }

    // Text {
    //     text: "No games here."
    //     anchors.centerIn: parent
    //     visible: gamesList.count == 0
    // }

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