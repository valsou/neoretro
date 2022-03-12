pragma Singleton
import QtQuick 2.15

QtObject {
    readonly property var primaryColor:  (function(manufacturer) { return data[manufacturer] ? data[manufacturer].primaryColor : "" })

    readonly property var data: {
        "amstrad":              { primaryColor: "#8D094F" },
        "apple":                { primaryColor: "#000000" },
        "atari":                { primaryColor: "#000000" },
        "capcom":               { primaryColor: "#000000" },
        "coleco":               { primaryColor: "#000000" },
        "commodore":            { primaryColor: "#000000" },
        "mattel":               { primaryColor: "#000000" },
        "microsoft":            { primaryColor: "#000000" },
        "nec":                  { primaryColor: "#000000" },
        "nintendo":             { primaryColor: "#C52128", altColor: "#060606" },
        "pc":                   { primaryColor: "#000000" },
        "sega":                 { primaryColor: "#4C87CA", altColor: "#355E9F" },
        "sammy":                { primaryColor: "#000000" },
        "sinclair":             { primaryColor: "#000000" },
        "smith_engineering":    { primaryColor: "#000000" },
        "snk":                  { primaryColor: "#5291D6", altColor: "#91BC36" },
        "sony":                 { primaryColor: "#000000", altColor: "#9DA19F" }
    }
}
