import QtQuick 2.15
import QtQuick.Layouts 1.15
import SortFilterProxyModel 0.2

import "../Global"

FocusScope {
    id: root

    property var lastGamePlayed: api.allGames.get(gamesLastPlayed.mapToSource(0))

    property var categories: [
        { name: "Last Played", games: gamesLastPlayed },
        { name: "Favorites", games: gamesFavorites },
        { name: "Recommendations", games: api.allGames },
        { name: "Random", games: api.allGames }
    ]

    ColumnLayout {
        anchors.fill: parent

        /* Last Game Played */
        FocusScope {
            id: lastPlayedGame

            focus: true

            Keys.onDownPressed: gridCategories.focus = true
            Keys.onPressed: {
                if (api.keys.isAccept(event)) {
                    event.accepted = true
                    lastGamePlayed.launch()
                }
            }

            Layout.preferredWidth: parent.width
            Layout.preferredHeight: parent.height * 0.4
            opacity: lastPlayedGame.activeFocus ? 1 : 0.1

            Rectangle {
                anchors.fill: parent
                color: textColor
            }

            Image {
                anchors.fill: parent
                sourceSize.width: width
                source: lastGamePlayed.assets.background ||
                        lastGamePlayed.assets.screnshot
                fillMode: Image.PreserveAspectCrop
                verticalAlignment: Image.AlignVCenter
            }

            Image {
                anchors.centerIn: parent
                width: parent.width * 0.7
                height: parent.height * 0.6
                sourceSize.width: width
                source: lastGamePlayed.assets.logo
                fillMode: Image.PreserveAspectFit
            }

            Rectangle {
                width: parent.width
                height: parent.height * 0.1
                anchors.bottom: parent.bottom
                color: textColor

                Text {
                    anchors {
                        right: parent.right
                        rightMargin: vpx(15)
                    }
                    text: lastGamePlayed.title
                    color: backgroundColor
                }
            }

            Rectangle {
                anchors.fill: parent
                color: "transparent"
                border {
                    width: lastPlayedGame.activeFocus ? vpx(5) : 0
                    color: "limegreen"
                }
            }

            // Text {
            //     anchors.centerIn: parent
            //     text: lastGamePlayed.title
            // }
        }
        /* <end> Last Game Played */

        ListView {
            id: gridCategories
            Layout.fillWidth: true
            Layout.fillHeight: true

            opacity: activeFocus ? 1 : 0.2

            Keys.onUpPressed: {
                if (currentIndex == 0) {
                    lastPlayedGame.focus = true
                }
                else {
                    decrementCurrentIndex()
                }
            }
            Keys.onDownPressed: incrementCurrentIndex()
            Keys.onRightPressed: currentItem.axis.incrementCurrentIndex()
            Keys.onLeftPressed: currentItem.axis.decrementCurrentIndex()

            focus: false

            orientation: ListView.Vertical

            model: categories

            delegate: ColumnLayout {
                property alias axis: gamesAxis
                readonly property ListView __categories: ListView.view
                readonly property bool __categoriesCurrentItem: ListView.isCurrentItem

                width: __categories.width
                height: __categoriesCurrentItem ? __categories.height * 0.6 : __categories.height * 0.1
                Behavior on height {
                    NumberAnimation { duration: 125 }
                }

                Text {
                    text: modelData.name
                    font {
                        family: regularDosis.name
                        pixelSize: vpx(26)
                    }
                    opacity: __categoriesCurrentItem ? 1 : 0.3
                    color: textColor
                }

                Rectangle {
                    id: emptyCategory
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    color: Qt.rgba(1, 1, 1, 0.1)
                    border {
                        width: vpx(1)
                        color: Qt.rgba(0, 0, 0, 0.1)
                    }
                    visible: !gamesAxis.visible && __categoriesCurrentItem

                    Text {
                        anchors.centerIn: parent
                        text: "Nothing to show"
                        font {
                            family: regularDosis.name
                            pixelSize: vpx(24)
                        }
                    }
                }

                ListView {
                    id: gamesAxis
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    orientation: ListView.Horizontal

                    highlightFollowsCurrentItem: true
                    highlightRangeMode: GridView.StrictlyEnforceRange

                    model: modelData.games
                    visible: modelData.games.count != 0 && __categoriesCurrentItem

                    delegate: HomeGameDelegate {}
                }

            }

        }
    }

}