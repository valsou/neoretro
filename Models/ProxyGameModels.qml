pragma Singleton
import QtQuick 2.15
import SortFilterProxyModel 0.2

Item {
    // Base Models
    property alias recentlyPlayedModel: recentlyPlayedModel
    property alias favoritedModel: favoritedModel

    //Games
    property alias recentlyPlayedGames: recentlyPlayedGames
    property alias favoritedGames: favoritedGames

    readonly property int maxItems: Variables.setHomeModelLimit.value - 1

    /* Upper Models */
    SortFilterProxyModel {
        id: recentlyPlayedModel
        sourceModel: api.allGames
        sorters: RoleSorter { roleName: 'lastPlayed'; sortOrder: Qt.DescendingOrder; }
        filters: ValueFilter { roleName: 'playCount'; value: 0; inverted: true }
    }

    SortFilterProxyModel {
        id: favoritedModel
        sourceModel: api.allGames
        sorters: RoleSorter { roleName: 'lastPlayed'; sortOrder: Qt.DescendingOrder; }
        filters:  ValueFilter { roleName: 'favorite'; value: true; }
    }

    /* Usable models */
    SortFilterProxyModel {
        id: recentlyPlayedGames
        sourceModel: recentlyPlayedModel
        filters: IndexFilter { minimumIndex: 1; maximumIndex: maxItems + 1 }
    }

    SortFilterProxyModel {
        id: favoritedGames
        sourceModel: favoritedModel
        filters: IndexFilter { maximumIndex: maxItems }
    }

}