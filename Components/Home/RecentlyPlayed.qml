import QtQuick 2.15
import QtQuick.Layouts 1.15

import "../Global"
import "../.."

FocusScope {
    id: root
    focus: true

    readonly property var game: api.allGames.get(ProxyGameModels.recentlyPlayedModel.mapToSource(games.currentIndex + 1))

    Item {
        width: parent.width
        height: parent.height * 0.09

        Text {
            width: parent.width
            height: parent.height * 0.7
            text: "RECENTLY PLAYED"
            font {
                family: fontSans.name
                pixelSize: height
                weight: Font.Light
            }
            verticalAlignment: Text.AlignBottom
        }
    }

    ListView {
        id: games
        focus: true

        width: parent.width
        height: parent.height * 0.91
        anchors.bottom: parent.bottom

        spacing: vpx(25)
        displayMarginBeginning: root.width * 0.8
        displayMarginEnd: root.width * 0.8
        orientation: ListView.Horizontal
        model: ProxyGameModels.recentlyPlayedGames
        // delegate: HomeGameDelegate {}
        delegate: Component {
            Loader {
                readonly property ListView __lv: ListView.view
                readonly property bool __isActiveFocus: activeFocus
                readonly property bool __isCurrentItem: ListView.isCurrentItem

                source: switch(chooseHomeTypeOfAssets) {
                    case "boxArt": return "DelegateHomeGamesBoxart.qml";
                    default: return "DelegateHomeGamesDefault.qml";
                }
            }
        }

        highlightRangeMode: ListView.ApplyRange
        highlightMoveDuration: 200
        highlightMoveVelocity: 200

        Keys.onLeftPressed: decrementCurrentIndex()
        Keys.onRightPressed: incrementCurrentIndex()
        Keys.onPressed: {
            if (api.keys.isAccept(event)) {
                event.accepted = true
                launchGame(game)
            }

            // if (api.keys.isDetails(event)) {
            //     event.accepted = true
            //     game.favorite = !game.favorite
            // }
        }
    }

}