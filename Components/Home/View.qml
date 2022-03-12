import QtQuick 2.15
import QtQuick.Layouts 1.15
import SortFilterProxyModel 0.2

ColumnLayout {
    id: root

    property var lastGamePlayed: api.allGames.get(gamesRecentlyPlayed.mapToSource(0))

    spacing: 0

    Item {
        width: root.width
        height: vpx(200)

        Rectangle {
            anchors.fill: parent
            color: "red"
            opacity: 0.2
            border {
                width: vpx(1)
                color: "black"
            }
        }
    }

    Item {
        width: root.width
        height: vpx(150)

        Rectangle {
            anchors.fill: parent
            color: "red"
            opacity: 0.2
            border {
                width: vpx(1)
                color: "black"
            }
        }
    }
    // Favorites {}
    // Random {}
    // Recommendations {}
}