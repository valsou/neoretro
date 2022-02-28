import QtQuick 2.15
import QtQml.Models 2.15
import SortFilterProxyModel 0.2

import "Components"
import "./utils.js" as Utils

FocusScope {
    id: root

    /* Fonts */
    FontLoader { id: lightDosis; source: "assets/fonts/Dosis-Light.ttf" }
    FontLoader { id: regularDosis; source: "assets/fonts/Dosis-Regular.ttf" }
    FontLoader { id: mediumDosis; source: "assets/fonts/Dosis-Medium.ttf" }
    FontLoader { id: semiboldDosis; source: "assets/fonts/Dosis-SemiBold.ttf" }
    FontLoader { id: boldDosis; source: "assets/fonts/Dosis-Bold.ttf" }

    FontLoader { id: fontAwesome; source: "assets/fonts/FontAwesome.otf" }

    FontLoader { id: googleMaterial; source: "assets/fonts/GoogleMaterial.otf" }
    FontLoader { id: googleMaterialRound; source: "assets/fonts/GoogleMaterialRound.otf" }
    /*******************/

    /* Global Settings */
    property bool darkTheme: api.memory.get("darkTheme") || false
    property bool enableMouse: false
    /*******************/

    /* Styling */
    readonly property var textColor: darkTheme ? Qt.rgba(0.7, 0.7, 0.7) : "black"
    readonly property var backgroundColor: darkTheme ? Qt.rgba(0, 0, 0) : Qt.rgba(1, 1, 1)
    /*******************/

    property int currentPageIndex: api.memory.get("currentPageIndex") || 0

    /* Games */
    property int currentGameIndex: 0
    property var currentGame: collections[currentCollectionIndex].games.get(currentGameIndex)
    property int gridColumns: api.memory.get("gamesGridColumns") || 5
    property int gridRows: api.memory.get("gamesGridRows") || 3


    /* Collections */
    property int currentCollectionIndex: api.memory.get('currentCollectionIndex') ?? 0
    property var collectionSortBy: "name"

    property bool showAllGamesCollection: api.memory.get("showAllGamesCollection") || false
    property bool showFavoritesCollection: api.memory.get("showFavoritesCollection") || false
    property bool showLastPlayedCollection: api.memory.get("showLastPlayedCollection") || false

    property var collections: {
        let collections = api.collections.toVarArray()

        if (showFavoritesCollection) {
            collections.unshift({
                "name":         "Favorites",
                "shortName":    "favorites",
                "games":        gamesFavorites
            })
        }

        if (showLastPlayedCollection) {
            collections.unshift({
                "name":         "Last Played",
                "shortName":    "lastplayed",
                "games":        gamesLastPlayed
            })
        }

        if (showAllGamesCollection) {
            collections.unshift({
                "name":         "All games",
                "shortName":    "all",
                "games":        api.allGames
            })
        }

        return collections
    }

    // [Collection] w/ only games favorites
    SortFilterProxyModel {
        id: gamesFavorites
        sourceModel: api.allGames
        filters: ValueFilter { roleName: 'favorite'; value: true; }
    }

    // [Collection] w/ only games recently played
    SortFilterProxyModel {
        id: gamesLastPlayed
        sourceModel: api.allGames
        sorters: RoleSorter { roleName: 'lastPlayed'; sortOrder: Qt.DescendingOrder }
        filters: ValueFilter { roleName: 'playCount'; value: 0; inverted: true }
    }

    /* States */
    states: [
        State { name: 'settingsView'; when: currentPageIndex == 0; PropertyChanges { target: contentLoader; source: "Components/Settings/View.qml" } },
        State { name: 'homeView'; when: currentPageIndex == 1; PropertyChanges { target: contentLoader; source: "Components/HomeView.qml" } },
        State { name: 'collectionsView'; when: currentPageIndex == 2; PropertyChanges { target: contentLoader; source: "Components/Collections/View.qml" } },
        State { name: 'gamesView'; when: currentPageIndex == 3; PropertyChanges { target: contentLoader; source: "Components/Games/View.qml" } }
    ]
    /* ------------------ */

    function prevPage() {
        if (currentPageIndex > 0) {
            currentPageIndex--
        }
    }

    function nextPage() {
        if (currentPageIndex < 3) {
            currentPageIndex++
        }
    }

    function prevCollection() {
        if (currentCollectionIndex > 0) {
            currentCollectionIndex--
        }
    }

    function nextCollection() {
        if (currentCollectionIndex < collections.length - 1) {
            currentCollectionIndex++
        }
    }

    Component.onDestruction: {
        api.memory.set('darkTheme', darkTheme)
        api.memory.set('gamesGridColumns', gridColumns)
        api.memory.set('gamesGridRows', gridRows)
        api.memory.set('currentPageIndex', currentPageIndex)
        api.memory.set('currentCollectionIndex', currentCollectionIndex)
    }

    Background {
        anchors.fill: parent
    }

    MouseArea {
        width: topLoader.width
        height: topLoader.height
        enabled: enableMouse
        hoverEnabled: true
        onEntered: topLoader.focus = true
        onExited: topLoader.focus = false
        onWheel: {
            if (wheel.angleDelta.y < 0) {
                prevPage()
            }
            else {
                nextPage()
            }
            wheel.accepted = true
        }
    }

    Loader {
        id: topLoader

        width: root.width * 0.8
        height: root.width * 0.05
        anchors.top: root.top
        anchors.horizontalCenter: root.horizontalCenter

        source: "Components/Header/View.qml"

        asynchronous: true
        focus: false
        opacity: topLoader.status === Loader.Ready ? 1 : 0
        Behavior on opacity { OpacityAnimator { duration: 300; from: 0 } }
        active: true

        Keys.onDownPressed: {
            focus = false
            contentLoader.focus = true
        }
    }

    Loader {
        id: contentLoader

        width: root.width * 0.8
        anchors.top: topLoader.bottom
        anchors.bottom: root.bottom
        anchors.horizontalCenter: root.horizontalCenter

        asynchronous: true
        focus: true
        visible: contentLoader.status === Loader.Ready ? 1 : 0
        opacity: {
            if (visible)
                if (focus) return 1.0
                else return 0.3
            return 0
        }
        // opacity: contentLoader.status === Loader.Ready ? 1 : 0
        Behavior on opacity { OpacityAnimator { duration: 300 } }
        active: true

        Keys.onUpPressed: {
            focus = false
            topLoader.focus = true
        }

        MouseArea {
            anchors.fill: parent
            enabled: enableMouse
            hoverEnabled: true
            onEntered: contentLoader.focus = true
            onExited: contentLoader.focus = false
        }
    }

    // Global event handler
    Keys.onPressed: {
        if (api.keys.isPrevPage(event)) {
            event.accepted = true
            prevPage()
        }
        if (api.keys.isNextPage(event)) {
            event.accepted = true
            nextPage()
        }

        // DEBUG DARK THEME
        if (api.keys.isFilters(event)) {
            event.accepted = true
            darkTheme = !darkTheme
        }
    }

    // Text {
    //     anchors {
    //         top: root.top
    //         right: root.right
    //     }
    //     text: "Grid columns : "+gridColumns+"\nGrid rows : "+gridRows
    //     color: "red"
    //     font.pixelSize: vpx(46)
    // }

}