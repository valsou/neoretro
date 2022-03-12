pragma Singleton
import QtQuick 2.15

QtObject {

    readonly property var manufacturer:  (function(shortname) { return data[shortname] ? data[shortname].manufacturer : "" })
    readonly property var releaseDate:  (function(shortname) { return data[shortname] ? data[shortname].release : "" })
    readonly property var primaryColor: (function(shortname) { return data[shortname] ? data[shortname].color : "" })
    readonly property var altColor: (function(shortname) { return data[shortname] ? data[shortname].altColor : "" })
    readonly property var boxFrontRatio: (function(shortname) { return data[shortname] ? data[shortname].boxFrontRatio : "" })


    readonly property var data: {
        "amstradcpc":       { manufacturer: "amstrad",              release: "1984",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "apple2":           { manufacturer: "apple",                release: "1977",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "atari2600":        { manufacturer: "atari",                release: "1977",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "atari5200":        { manufacturer: "atari",                release: "1982",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "atarist":          { manufacturer: "atari",                release: "1985",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "atari7800":        { manufacturer: "atari",                release: "1986",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "atarilynx":        { manufacturer: "atari",                release: "1989",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "atarijaguar":      { manufacturer: "atari",                release: "1993",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "cps1":             { manufacturer: "capcom",               release: "1988",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "cps2":             { manufacturer: "capcom",               release: "1993",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "cps3":             { manufacturer: "capcom",               release: "1996",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "colecovision":     { manufacturer: "coleco",               release: "1982",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "c64":              { manufacturer: "commodore",            release: "1982",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "amiga":            { manufacturer: "commodore",            release: "1985",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "intellivision":    { manufacturer: "mattel",               release: "1979",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "msx":              { manufacturer: "microsoft",            release: "1983",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "msx2":             { manufacturer: "microsoft",            release: "1985",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "pcengine":         { manufacturer: "nec",                  release: "1987",            color: "#96040C", altColor: "#7E040B",  boxFrontRatio: "" },
        "turbografx16":     { manufacturer: "nec",                  release: "1987",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "supergrafx":       { manufacturer: "nec",                  release: "1989",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "pcfx":             { manufacturer: "nec",                  release: "1994",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "nes":              { manufacturer: "nintendo",             release: "1983",            color: "#272727", altColor: "#656565",  boxFrontRatio: "62:85" },
        "fds":              { manufacturer: "nintendo",             release: "1986",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "gb":               { manufacturer: "nintendo",             release: "1989",            color: "#241078", altColor: "#010D50",  boxFrontRatio: "1:1" },
        "snes":             { manufacturer: "nintendo",             release: "1990",            color: "#84E8A7", altColor: "#65A57B",  boxFrontRatio: "34:25" },
        "virtualboy":       { manufacturer: "nintendo",             release: "1995",            color: "#e60012", altColor: "#B10210",  boxFrontRatio: "" },
        "n64":              { manufacturer: "nintendo",             release: "1996",            color: "#45832D", altColor: "#356F20",  boxFrontRatio: "" },
        "gbc":              { manufacturer: "nintendo",             release: "1998",            color: "#997F03", altColor: "#725E00",  boxFrontRatio: "" },
        "gba":              { manufacturer: "nintendo",             release: "2001",            color: "#1E02B4", altColor: "#19077C",  boxFrontRatio: "" },
        "gc":               { manufacturer: "nintendo",             release: "2001",            color: "#441BA3", altColor: "#24066A",  boxFrontRatio: "" },
        "nds":              { manufacturer: "nintendo",             release: "2004",            color: "#B4B4B4", altColor: "#363636",  boxFrontRatio: "" },
        "wii":              { manufacturer: "nintendo",             release: "2006",            color: "#75C4D4", altColor: "#D2EBF0",  boxFrontRatio: "" },
        "wiiware":          { manufacturer: "nintendo",             release: "2008",            color: "#75C4D4", altColor: "#D2EBF0",  boxFrontRatio: "" },
        "3ds":              { manufacturer: "nintendo",             release: "2011",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "wiiu":             { manufacturer: "nintendo",             release: "2012",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "switch":           { manufacturer: "nintendo",             release: "2017",            color: "#e60012", altColor: "#B10210",  boxFrontRatio: "" },
        "3do":              { manufacturer: "panasonic",            release: "1993",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "atomiswave":       { manufacturer: "sammy",                release: "2003",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "mastersystem":     { manufacturer: "sega",                 release: "1985",            color: "#A71010", altColor: "#790303",  boxFrontRatio: "" },
        "genesis":          { manufacturer: "sega",                 release: "1988",            color: "#230000", altColor: "#180000",  boxFrontRatio: "121:170" },
        "megadrive":        { manufacturer: "sega",                 release: "1988",            color: "#C72031", altColor: "#180000",  boxFrontRatio: "121:170" },
        "gamegear":         { manufacturer: "sega",                 release: "1990",            color: "#0D1114", altColor: "#1F1F1F",  boxFrontRatio: "" },
        "segacd":           { manufacturer: "sega",                 release: "1991",            color: "#010314", altColor: "#02062B",  boxFrontRatio: "" },
        "sega32x":          { manufacturer: "sega",                 release: "1994",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "saturn":           { manufacturer: "sega",                 release: "1994",            color: "#3B3A9C", altColor: "#292885",  boxFrontRatio: "" },
        "dreamcast":        { manufacturer: "sega",                 release: "1998",            color: "#FB7A33", altColor: "#C0571C",  boxFrontRatio: "" },
        "zxspectrum":       { manufacturer: "sinclair",             release: "1982",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "vectrex":          { manufacturer: "smith_engineering",    release: "1982",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "neogeo":           { manufacturer: "snk",                  release: "1990",            color: "#08B5D5", altColor: "#008199",  boxFrontRatio: "" },
        "neogeocd":         { manufacturer: "snk",                  release: "1994",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "ngp":              { manufacturer: "snk",                  release: "1998",            color: "#93192D", altColor: "#6B0909",  boxFrontRatio: "" },
        "ngpc":             { manufacturer: "snk",                  release: "1999",            color: "#C72031", altColor: "#5C056B",  boxFrontRatio: "599:700" },
        "psx":              { manufacturer: "sony",                 release: "1994",            color: "#BE002C", altColor: "#252525",  boxFrontRatio: "792:680" },
        "ps2":              { manufacturer: "sony",                 release: "2000",            color: "#3144B1", altColor: "#00224C",  boxFrontRatio: "" },
        "psp":              { manufacturer: "sony",                 release: "2004",            color: "#050C10", altColor: "#6A818C",  boxFrontRatio: "" },
        "ps3":              { manufacturer: "sony",                 release: "2006",            color: "#0D1114", altColor: "#1F1F1F",  boxFrontRatio: "" },
        "gog":              { manufacturer: "pc",                   release: "2008",            color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "steam":            { manufacturer: "pc",                   release: "2003",            color: "#010314", altColor: "#252525",  boxFrontRatio: "" },
        "arcade":           { manufacturer: "",                     release: "",                color: "#D00E2D", altColor: "#9B071E",  boxFrontRatio: "62:85" },
        "all":              { manufacturer: "",                     release: "",                color: "#FFD019", altColor: "#FF9919",  boxFrontRatio: "" },
        "daphne":           { manufacturer: "",                     release: "",                color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "fba":              { manufacturer: "",                     release: "",                color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "fbneo":            { manufacturer: "",                     release: "",                color: "#000000", altColor: "#252525",  boxFrontRatio: "" },
        "mame":             { manufacturer: "",                     release: "",                color: "#000000", altColor: "#252525",  boxFrontRatio: "" }
    }
}
