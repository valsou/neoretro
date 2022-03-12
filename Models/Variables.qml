pragma Singleton
import QtQuick 2.15
import QtQml.Models 2.15

import "../Components/Custom"

QtObject {
    property var settings: [
        {
            name: Localization.get("menu_general"),
            model: [    chooseLanguage,
                        enableDarkTheme,
                        enableBatteryStatus ]
        },
        {
            name: Localization.get("menu_home"),
            model: [    chooseHomeTypeOfAssets,
                        chooseHomeRatioCards,
                        setHomeModelLimit ]
        },
        {
            name: Localization.get("menu_collections"),
            model: [    enableCollectionsPage ]
        },
        {
            name: Localization.get("menu_library"),
            model: [    chooseLibraryTypeOfAssets,
                        gridNumberOfColumns,
                        gridNumberOfRows,
                        chooseDetailsViewLayout,
                        chooseLibraryRatioCards,
                        enableLibraryBelowInfo ]
        }
    ]

    /*
        [SettingBool]
        value               -> bool
        increment()         -> value = !value
        decrement()         -> value = !value

        [SettingInteger]
        value               -> int
        min                 -> int
        max                 -> int
        increment()         -> value = value + 1 OR value (max limit)
        decrement()         -> value = value - 1 OR value (min limit)

        [SettingArray]
        value               -> var (string)
        possibilities       -> var (array)
        increment()         -> value = next value in array OR last value in array
        decrement()         -> value = previous value in array OR first value in array
    */

    /* General */
    property var enableDarkTheme: SettingBool {
        title: Localization.get("settingsTitle_enableDarkTheme")
        description: Localization.get("settingsDesc_enableDarkTheme")
        value: api.memory.get("enableDarkTheme") || false
    }

    property var enableBatteryStatus: SettingBool {
        title: Localization.get("settingsTitle_enableBatteryStatus")
        description: Localization.get("settingsDesc_enableBatteryStatus")
        value: api.memory.get("enableBatteryStatus") || false
    }

    property var chooseLanguage: SettingArray {
        title: Localization.get("settingsTitle_chooseLanguage")
        description: Localization.get("settingsDesc_chooseLanguage")
        value: api.memory.get("chooseLanguage") || "en"
        possibilities: ["en", "fr"]
    }

    property var enableTwentyFourTime: SettingBool {
        title: Localization.get("settingsTitle_enableTwentyFourTime")
        description: Localization.get("settingsDesc_enableTwentyFourTime")
        value: api.memory.get("enableTwentyFourTime") || true
    }

    /* Home */
    property var chooseHomeTypeOfAssets: SettingArray {
        title: "Assets"
        description: "Choose what kind of assets you want to see in Home sections (except last game played). In each case there will be a fallback if the asset does not exist."
        value: api.memory.get("chooseHomeTypeOfAssets") || "screenshot+logo"
        possibilities: ["screenshot+logo", "boxArt"]
    }

    property var chooseHomeRatioCards: SettingArray {
        title: "Aspect ratio"
        description: "Choose aspect ratio for cards. Hint: [horizontal size]:[vertical size]. This option does nothing if asset type is different than screenshot+logo."
        value: api.memory.get("chooseHomeRatioCards") || "1:1"
        possibilities: ["1:1", "4:3", "16:10", "3:4", "2:3", "10:16"]
    }

    property var setHomeModelLimit: SettingInteger {
        title: "Games per row"
        description: "Set maxmium number of games to show in each row."
        value: api.memory.get("setHomeModelLimit") || 10
        min: 5
        max: 15
    }

    /* Collections */
    property var enableCollectionsPage: SettingBool {
        title: "Collections page"
        description: "Enable Collections page."
        value: api.memory.get("enableCollectionsPage") || true
    }

    property var chooseCollectionsAssetsRegion: SettingArray {
        title: "Assets region"
        description: "Choose from which region should assets come from."
        value: api.memory.get("chooseCollectionsAssetsRegion") || "usa"
        possibilities: ["europe", "japan", "usa"]
    }

    /* Library */
    property var chooseLibraryTypeOfAssets: SettingArray {
        title: "Assets"
        description: "Choose what kind of assets you want to see in Library. In each case there will be a fallback if the asset does not exist."
        value: api.memory.get("chooseLibraryTypeOfAssets") || "screenshot+logo"
        possibilities: ["screenshot+logo", "boxArt"]
    }

    property var gridNumberOfColumns: SettingInteger {
        title: "Columns"
        description: "Set number of columns in the grid for displaying games."
        value: api.memory.get("gridNumberOfColumns") || 4
        min: 1
        max: 12
    }

    property var gridNumberOfRows: SettingInteger {
        title: "Rows"
        description: "Set number of rows in the grid for displaying games."
        value: api.memory.get("gridNumberOfRows") || 3
        min: 1
        max: 4
    }

    property var chooseLibraryRatioCards: SettingArray {
        title: "Aspect ratio"
        description: "Choose aspect ratio for cards. Hint: [horizontal size]:[vertical size]. This option does nothing if asset type is different than screenshot+logo."
        value: api.memory.get("chooseLibraryRatioCards") || "1:1"
        possibilities: ["1:1", "4:3", "16:10", "3:4", "2:3", "10:16"]
    }

    property var chooseRatingStyle: SettingArray {
        title: "Rating style"
        description: "Choose rating style"
        value: api.memory.get("chooseRatingStyle") || "stars"
        possibilities: ["stars", "percentage", "smileys"]
    }

    property var enableLibraryBelowInfo: SettingBool {
        title: "Title & more card information"
        description: "Enable information (title, year release, genre, ...) below the card."
        value: api.memory.get("enableLibraryBelowInfo") || true
    }

    property var chooseDetailsViewLayout: SettingArray {
        title: "Details view layout"
        description: "Choose view layout when you toggle game details. Either horizontal or vertical."
        value: api.memory.get("chooseDetailsViewLayout") || "horizontal"
        possibilities: ["horizontal", "vertical"]
    }

}