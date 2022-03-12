pragma Singleton
import QtQuick 2.15

QtObject {
    readonly property var language: Variables.chooseLanguage.value

    property var get: function(string) {
        return translations[language][string] || translations["en"][string] || "<unknown word>"
    }

    readonly property var translations: {

        //=> English
        "en": {
            /* Menu */
            "menu_home":                            "Home",
            "menu_collections":                     "Collections",
            "menu_library":                         "Library",
            "menu_general":                         "General",
            /* Home sections */
            "home_recentlyPlayed":                  "Recently Played",
            "home_favorites":                       "Favorites",
            /* Settings titles */
            /* ... General */
            "settingsTitle_enableDarkTheme":        "Dark theme",
            "settingsTitle_enableBatteryStatus":    "Battery status",
            "settingsTitle_chooseLanguage":         "Language",
            "settingsTitle_enableTwentyFourTime":   "24-hour clock",
            /* Settings descriptions */
            "settingsDesc_enableBatteryStatus":     "Enable battery status information (icon & percentage) in the header next to the time",
            "settingsDesc_enableTwentyFourTime":    "Enable 24-hour clock convention. Otherwise 12-hour. Might require that you put your OS in 12-hour mode to see AM and PM suffixes",
            "settingsDesc_chooseLanguage":          "Choose interface language",
            "settingsDesc_enableDarkTheme":         "Enable dark theming, otherwise light theming (default)"
        },

        //=> French
        "fr": {
            /* Menu */
            "menu_home":                        "Accueil",
            "menu_collections":                 "Collections",
            "menu_library":                     "Bibliothèque",
            "menu_general":                     "Général",
            /* Home sections */
            "home_recentlyPlayed":              "Joué récemment",
            "home_favorites":                   "Favoris",
            /* Settings descriptions */
            "settingsDesc_chooseLanguage":       "Choisir la langue de l'interface",
            "settingsDesc_enableDarkTheme":      "Activer le thème sombre, sinon le thème clair sera sélectionné par défaut"
        }
    }

}