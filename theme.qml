import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQml.Models 2.15
import QtGraphicalEffects 1.15
import SortFilterProxyModel 0.2

import "."
import "Components"
import "Components/Global"
import "Components/Header" as Header
import "Components/Home" as Home
import "Components/Collections" as Collections
import "Components/Library" as Library
import "Components/Settings" as Settings
import "./utils.js" as Utils

FocusScope {
    id: root

    /* Fonts */
    FontLoader { id: lightDosis; source: "assets/fonts/Dosis-Light.ttf" }
    FontLoader { id: regularDosis; source: "assets/fonts/Dosis-Regular.ttf" }
    FontLoader { id: mediumDosis; source: "assets/fonts/Dosis-Medium.ttf" }
    FontLoader { id: semiboldDosis; source: "assets/fonts/Dosis-SemiBold.ttf" }
    FontLoader { id: boldDosis; source: "assets/fonts/Dosis-Bold.ttf" }
    FontLoader { id: googleMaterial; source: "assets/fonts/GoogleMaterial.otf" }
    FontLoader { id: googleMaterialRound; source: "assets/fonts/GoogleMaterialRound.otf" }

    FontLoader { id: fontSans; source: "assets/fonts/Manrope.ttf" }
    /*******************/

    /* Global Settings */
    property bool enableDarkTheme: Variables.enableDarkTheme.value
    property bool enableMouse: false
    property bool enableBatteryStatus: Variables.enableBatteryStatus.value
    property bool enableAPTime: api.memory.get("enableAPTime") ?? false
    /*******************/

    /* Styling */
    readonly property int pagesWidth: root.width * 0.85
    readonly property int headerHeight: root.height * 0.08
    readonly property int pagesHeight: root.height * 0.92
    readonly property var textColor: enableDarkTheme ? Qt.rgba(0.7, 0.7, 0.7) : "black"
    readonly property var backgroundColor: enableDarkTheme ? Qt.rgba(0, 0, 0) : Qt.rgba(1, 1, 1)

    property real skewAngle: Utils.getRandomSkewAngle()
    /*******************/

    /* Menu */
    property var mainStates: ["homeView", "collectionsView", "libraryView"]

    property int currentPageIndex: api.memory.get("currentPageIndex") || 0
    property int currentMenuIndex: 0


    /* Home */
    property var chooseHomeTypeOfAssets: Variables.chooseHomeTypeOfAssets.value
    property var chooseHomeRatioCards: Variables.chooseHomeRatioCards.value
    property int setHomeModelLimit: Variables.setHomeModelLimit.value

    /* Games */
    property int currentGameIndex: 0
    property var currentGame: (pagesModelProxy[currentPageIndex].name == "library") ? collections[currentCollectionIndex].games.get(proxyModel.mapToSource(currentGameIndex)) : null
    property int gridNumberOfColumns: Variables.gridNumberOfColumns.value
    property int gridNumberOfRows: Variables.gridNumberOfRows.value
    property var chooseLibraryTypeOfAssets: Variables.chooseLibraryTypeOfAssets.value
    property var chooseDetailsViewLayout: Variables.chooseDetailsViewLayout.value
    property bool enableDetailsView: api.memory.get("enableDetailsView") ?? false
    property var chooseLibraryRatioCards: Variables.chooseLibraryRatioCards.value
    property bool enableLibraryBelowInfo: Variables.enableLibraryBelowInfo.value

    ListModel {
        id: librarySorterList

        ListElement {
            name: "title"
            label: "Title"
            order: Qt.AscendingOrder
        }
        ListElement {
            name: "developer"
            label: "Developer"
            order: Qt.AscendingOrder
        }
        ListElement {
            name: "publisher"
            label: "Publisher"
            order: Qt.AscendingOrder
        }
        ListElement {
            name: "genre"
            label: "Genre"
            order: Qt.AscendingOrder
        }
        ListElement {
            name: "releaseYear"
            label: "Year"
            order: Qt.AscendingOrder
        }
        ListElement {
            name: "players"
            label: "Players"
            order: Qt.AscendingOrder
        }
        ListElement {
            name: "rating"
            label: "Rating"
            order: Qt.AscendingOrder
        }
    }

    property int currentLibrarySorterIndex: 0
    property var libraryFilterFavorites: false

    /* Collections */
    property bool enableCollectionsPage: Variables.enableCollectionsPage.value

    property int currentCollectionIndex: api.memory.get('currentCollectionIndex') ?? 0
    property var currentCollection: collections[currentCollectionIndex]

    property bool showAllGamesCollection: api.memory.get("showAllGamesCollection") ?? false
    property bool showFavoritesCollection: api.memory.get("showFavoritesCollection") ?? false
    property bool showLastPlayedCollection: api.memory.get("showLastPlayedCollection") ?? false

    property var collections: {
        let collections = api.collections.toVarArray()

        for (let i=0; i<collections.length; i++) {
            collections[i].manufacturer = Consoles.manufacturer(collections[i].shortName)
            collections[i].releaseYear = Consoles.releaseDate(collections[i].shortName)
            collections[i].boxFrontRatio = Consoles.boxFrontRatio(collections[i].shortName)
        }


        collections.unshift({
            "name":         "All Games",
            "shortName":    "all",
            "games":        api.allGames
        })

        // if (showFavoritesCollection) {
        //     collections.unshift({
        //         "name":         "Favorites",
        //         "shortName":    "favorites",
        //         "games":        gamesFavorites
        //     })
        // }

        // Sorting by year
        collections.sort(function(a, b) {
            return a.releaseYear - b.releaseYear
        })

        // // Sorting by manufacturer
        // collections.sort(function(a, b) {
        //     if (a.manufacturer < b.manufacturer) {
        //         return -1;
        //     }
        //     if (a.manufacturer > b.manufacturer) {
        //         return 1;
        //     }
        //     // names must be equal
        //     return 0;
        // })

        return collections
    }

    // // Proxy Collections Model
    // SortFilterProxyModel {
    //     id: proxyCollectionsModel
    //     sourceModel: collections
    //     sorters: RoleSorter { roleName: "manufacturer"; sortOrder: Qt.AscendingOrder }
    //     // filters: ValueFilter { roleName: "favorite"; value: true; enabled: libraryFilterFavorites }
    // }

    // Proxy Model
    SortFilterProxyModel {
        id: proxyModel
        sourceModel: collections[currentCollectionIndex].games
        sorters: RoleSorter { roleName: librarySorterList.get(currentLibrarySorterIndex).name; sortOrder: librarySorterList.get(currentLibrarySorterIndex).order }
        filters: ValueFilter { roleName: "favorite"; value: true; enabled: libraryFilterFavorites }
    }

    property var pagesModelList: [ "lastGamePlayed", "recentlyPlayed", "favorites", "collections", "library" ]

    /* Pages (base model) */
    property var pagesModel: [
        //=> Last game played
        {
            name: "lastGamePlayed",
            heightSize: 0.62,
            page: "Home/LastGamePlayed.qml",
            bgColorBegin: "#81FAF0",
            bgColorEnd: "#00CCDE",
            bgAngle: -4,
            enabled: true
        },
        //=> Games Recently Played
        {
            name: "gamesRecentlyPlayed",
            heightSize: 0.56,
            page: "Home/RecentlyPlayed.qml",
            bgColorBegin: "#FF9143",
            bgColorEnd: "#FFE662",
            bgAngle: 0.8,
            enabled: true
        },
        //=> Favorited games
        {
            name: "favoritedGames",
            heightSize: 0.56,
            page: "Home/Favorites.qml",
            bgColorBegin: "#9B53FF",
            bgColorEnd: "#FF285B",
            bgAngle: -0.6,
            enabled: true
        },

        //=> TODO: Recommendations games
        //=> TODO: Random games

        //=> Collections
        {
            name: "collections",
            heightSize: 0.8,
            page: "Collections/View.qml",
            bgColor: "#79FFCF",
            bgAngle: 0.8,
            enabled: enableCollectionsPage
        },
        //=> Library
        {
            name: "library",
            heightSize: 1,
            page: "Library/View.qml",
            bgColor: "#79FFCF",
            bgAngle: 0.8,
            enabled: true
        }
    ]

    /* Pages (proxied model) - show only pages that are enabled */
    /* Used by ./pagesList ListView */
    property var pagesModelProxy: pagesModel.filter(page => page.enabled == true)

    /* Menu (base model) */
    property var menuModel: [
        {
            name: Localization.get("menu_home"),
            color: "red",
            enabled: true
        },
        {
            name: Localization.get("menu_collections"),
            color: "blue",
            enabled: enableCollectionsPage
        },
        {
            name: Localization.get("menu_library"),
            color: "green",
            enabled: true
        }
    ]

    /* Menu (proxied model) - don't show Collections page if disabled */
    /* Used by Header/Menu ListView */
    property var menuModelProxy: menuModel.filter(menu => menu.enabled == true)

    /* States */
    states: [
        //=> TODO: Loading spinner when Loader.status === Loader.Loading
        State {
            name: "mainView"
            PropertyChanges { target: contentLoader; sourceComponent: mainContent }
        },
        State {
            name: "settingsView"
            PropertyChanges { target: contentLoader; sourceComponent: settingsContent }
        }
    ]
    /* ------------------ */
    state: "mainView"

    /* Sync Pages position with Menu position */
    function syncMenuToPages() {
        switch (enableCollectionsPage) {
            case true:
                if (currentMenuIndex == menuModelProxy.length - 1) {
                    currentPageIndex = pagesModelProxy.length - 1
                }
                else if (currentMenuIndex == menuModelProxy.length - 2) {
                    currentPageIndex = pagesModelProxy.length - 2
                }
                else {
                    currentPageIndex = 0
                }
                break

            default:
                if (currentMenuIndex == menuModelProxy.length - 1) {
                    currentPageIndex = pagesModelProxy.length - 1
                }
                else {
                    currentPageIndex = 0
                }
                break
        }
    }

    /* Sync Pages position with Menu position */
    function syncPagesToMenu() {
        switch (enableCollectionsPage) {
            case true:
                if (currentPageIndex == pagesModelProxy.length - 1) {
                    currentMenuIndex = menuModelProxy.length - 1
                }
                else if (currentPageIndex == pagesModelProxy.length - 2) {
                    currentMenuIndex = menuModelProxy.length - 2
                }
                else {
                    currentMenuIndex = 0
                }
                break

            default:
                if (currentPageIndex == pagesModelProxy.length - 1) {
                    currentMenuIndex = menuModelProxy.length - 1
                }

                else {
                    currentMenuIndex = 0
                }
                break
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

    function launchGame(game) {
        // contentLoader.opacity = 0
        // contentLoader.scale = 3.0
        console.log(game.title)
        game.launch()
    }

    function getAssetsRatio(games) {
        for (i=0; i<games.count; i++) {
            if (games[i].assets.boxFront) {
                ratioTester.source = games[i].assets.boxFront
                return ratioTester.sourceSize
            }
        }
    }

    Component.onDestruction: {
        // Collections
        api.memory.set("enableCollectionsPage", enableCollectionsPage)
        // Games
        api.memory.set("gridNumberOfColumns", gridNumberOfColumns)
        api.memory.set("gridNumberOfRows", gridNumberOfRows)
        api.memory.set("chooseDetailsViewLayout", chooseDetailsViewLayout)
        api.memory.set("enableDetailsView", enableDetailsView)
        api.memory.set("chooseLibraryTypeOfAssets", chooseLibraryTypeOfAssets)
        api.memory.set("chooseLibraryRatioCards", chooseLibraryRatioCards)
        api.memory.set("enableLibraryBelowInfo", enableLibraryBelowInfo)
        // Home
        api.memory.set("chooseHomeTypeOfAssets", chooseHomeTypeOfAssets)
        api.memory.set("chooseHomeRatioCards", chooseHomeRatioCards)
        api.memory.set("setHomeModelLimit", setHomeModelLimit)
        // General
        api.memory.set("enableDarkTheme", enableDarkTheme)
        api.memory.set("enableBatteryStatus", enableBatteryStatus)
        api.memory.set("currentPageIndex", currentPageIndex)
        api.memory.set("currentCollectionIndex", currentCollectionIndex)
    }

    // Hidden image with purpose to get correct ratio of Boxarts
    Image {
        id: ratioTester
        visible: false
    }

    Background {
        id: background
        pageFocused: contentLoader.item.page.activeFocus
        anchors.fill: parent
    }

    /* Loading animation when loader is loading */
    LoadingElement {
        width: parent.width * 0.3
        height: parent.height * 0.1
        anchors.centerIn: parent

        loading: contentLoader.status === Loader.Loading

        opacity: loading
        Behavior on opacity { NumberAnimation { duration: 200 } }
    }

    Component {
        id: mainContent

        ColumnLayout {
            id: main

            property alias page: pagesList

            /* States */
            states: [
                //=> TODO: Loading spinner when Loader.status === Loader.Loading
                State {
                    name: "headerView"
                    PropertyChanges { target: headerView; focus: true }
                    PropertyChanges { target: pagesList; opacity: 0.2 }
                },
                State {
                    name: "listView"
                    PropertyChanges { target: pagesList; focus: true }
                }
            ]
            /* ------------------ */
            state: "listView"

            anchors.fill: parent
            spacing: 0

            // Header
            Header.View {
                id: headerView
                z: 1

                focus: false
                Layout.preferredWidth: root.width
                Layout.preferredHeight: headerHeight
                Layout.alignment: Qt.AlignTop

                Keys.onDownPressed: {
                    event.accepted = true
                    main.state = "listView"
                }
            }

            ListView {
                id: pagesList

                Behavior on opacity { NumberAnimation { duration: 200 } }
                Behavior on height { NumberAnimation { duration: 700 } }

                focus: false

                Layout.preferredWidth: pagesWidth
                Layout.preferredHeight: pagesHeight * 0.95
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

                displayMarginBeginning: root.height * 2
                displayMarginEnd: root.height * 2

                spacing: height * 0.2
                orientation: ListView.Vertical

                highlightRangeMode: ListView.StrictlyEnforceRange
                highlightMoveDuration: 350
                highlightMoveVelocity: 400

                boundsBehavior: Flickable.StopAtBounds

                currentIndex: currentPageIndex

                onCurrentIndexChanged: {
                    currentPageIndex = currentIndex
                    syncPagesToMenu()
                    background.colorTouchAnimation.restart()
                }

                onActiveFocusChanged: {
                    background.colorTouchAnimation.restart()
                }

                Component.onCompleted: positionViewAtIndex(currentPageIndex, ListView.SnapPosition)

                model: pagesModelProxy

                delegate: Component {
                    Loader {
                        width: ListView.view.width
                        height: ListView.view.height * modelData.heightSize
                        source: "Components/"+modelData.page
                    }
                }

                Keys.onDownPressed: incrementCurrentIndex()
                Keys.onUpPressed: {
                    if (currentPageIndex == 0) {
                        main.state = "headerView"
                    }
                    if (currentPageIndex < count - 1) {
                        decrementCurrentIndex()
                    }
                }

                /* Global key events */
                Keys.onPressed: {
                    //-> Previous Menu Page
                    if (api.keys.isPrevPage(event)) {
                        event.accepted = true
                        headerView.aliasMenu.decrementCurrentIndex()
                    }
                    //-> Next Menu Page
                    if (api.keys.isNextPage(event)) {
                        event.accepted = true
                        headerView.aliasMenu.incrementCurrentIndex()
                    }
                    //-> Open Settings Page
                    if (api.keys.isMenu(event)) {
                        event.accepted = true
                        root.state = "settingsView"
                    }

                    if (api.keys.isCancel(event)) {
                        if (currentPageIndex > 0) {
                            event.accepted = true
                            currentPageIndex--
                        }
                        else {
                            event.accepted = false
                        }
                    }
                }

            }

        }
    }

    Component {
        id: settingsContent

        Settings.View {
            id: settingsView
            anchors.fill: parent

            Keys.onPressed: {
                //-> Close Settings Page
                if (api.keys.isCancel(event)) {
                    event.accepted = true
                    root.state = "mainView"
                }
                if (api.keys.isMenu(event)) {
                    event.accepted = true
                    root.state = "mainView"
                }
            }
        }
    }

    Loader {
        id: contentLoader

        anchors.fill: root

        asynchronous: false
        focus: true
        visible: contentLoader.status === Loader.Ready ? 1 : 0
        opacity: visible
        Behavior on scale { NumberAnimation { duration: 700 } }
        Behavior on opacity { OpacityAnimator { duration: 500 } }
        active: active
    }

    // Text {
    //     text: currentGame ? currentGame.title : "null"
    //     // text: contentLoader.item.page.currentItem.currentGame.title
    //     anchors {
    //         top: root.top
    //         right: root.right
    //     }
    //     color: "red"
    //     font.pixelSize: vpx(34)
    // }

}