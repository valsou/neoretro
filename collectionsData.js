let get = {
    "amstradcpc":       { manufacturer: "amstrad",              release: "1984",    color: "#000000", altColor: "#252525" },
    "apple2":           { manufacturer: "apple",                release: "1977",    color: "#000000", altColor: "#252525" },
    "atari2600":        { manufacturer: "atari",                release: "1977",    color: "#000000", altColor: "#252525" },
    "atari5200":        { manufacturer: "atari",                release: "1982",    color: "#000000", altColor: "#252525" },
    "atarist":          { manufacturer: "atari",                release: "1985",    color: "#000000", altColor: "#252525" },
    "atari7800":        { manufacturer: "atari",                release: "1986",    color: "#000000", altColor: "#252525" },
    "atarilynx":        { manufacturer: "atari",                release: "1989",    color: "#000000", altColor: "#252525" },
    "atarijaguar":      { manufacturer: "atari",                release: "1993",    color: "#000000", altColor: "#252525" },
    "cps1":             { manufacturer: "capcom",               release: "1988",    color: "#000000", altColor: "#252525" },
    "cps2":             { manufacturer: "capcom",               release: "1993",    color: "#000000", altColor: "#252525" },
    "cps3":             { manufacturer: "capcom",               release: "1996",    color: "#000000", altColor: "#252525" },
    "colecovision":     { manufacturer: "coleco",               release: "1982",    color: "#000000", altColor: "#252525" },
    "c64":              { manufacturer: "commodore",            release: "1982",    color: "#000000", altColor: "#252525" },
    "amiga":            { manufacturer: "commodore",            release: "1985",    color: "#000000", altColor: "#252525" },
    "intellivision":    { manufacturer: "mattel",               release: "1979",    color: "#000000", altColor: "#252525" },
    "msx":              { manufacturer: "microsoft",            release: "1983",    color: "#000000", altColor: "#252525" },
    "msx2":             { manufacturer: "microsoft",            release: "1985",    color: "#000000", altColor: "#252525" },
    "pcengine":         { manufacturer: "nec",                  release: "1987",    color: "#96040C", altColor: "#7E040B" },
    "turbografx16":     { manufacturer: "nec",                  release: "1987",    color: "#000000", altColor: "#252525" },
    "supergrafx":       { manufacturer: "nec",                  release: "1989",    color: "#000000", altColor: "#252525" },
    "pcfx":             { manufacturer: "nec",                  release: "1994",    color: "#000000", altColor: "#252525" },
    "nes":              { manufacturer: "nintendo",             release: "1983",    color: "#272727", altColor: "#656565" },
    "fds":              { manufacturer: "nintendo",             release: "1986",    color: "#000000", altColor: "#252525" },
    "gb":               { manufacturer: "nintendo",             release: "1989",    color: "#031268", altColor: "#010D50" },
    "snes":             { manufacturer: "nintendo",             release: "1990",    color: "#84E8A7", altColor: "#65A57B" },
    "virtualboy":       { manufacturer: "nintendo",             release: "1995",    color: "#e60012", altColor: "#B10210" },
    "n64":              { manufacturer: "nintendo",             release: "1996",    color: "#45832D", altColor: "#356F20" },
    "gbc":              { manufacturer: "nintendo",             release: "1998",    color: "#997F03", altColor: "#725E00" },
    "gba":              { manufacturer: "nintendo",             release: "2001",    color: "#1E02B4", altColor: "#19077C" },
    "gc":               { manufacturer: "nintendo",             release: "2001",    color: "#441BA3", altColor: "#24066A" },
    "nds":              { manufacturer: "nintendo",             release: "2004",    color: "#B4B4B4", altColor: "#363636" },
    "wii":              { manufacturer: "nintendo",             release: "2006",    color: "#75C4D4", altColor: "#D2EBF0" },
    "wiiware":          { manufacturer: "nintendo",             release: "2008",    color: "#75C4D4", altColor: "#D2EBF0" },
    "3ds":              { manufacturer: "nintendo",             release: "2011",    color: "#000000", altColor: "#252525" },
    "wiiu":             { manufacturer: "nintendo",             release: "2012",    color: "#000000", altColor: "#252525" },
    "switch":           { manufacturer: "nintendo",             release: "2017",    color: "#e60012", altColor: "#B10210" },
    "3do":              { manufacturer: "panasonic",            release: "1993",    color: "#000000", altColor: "#252525" },
    "atomiswave":       { manufacturer: "sammy",                release: "2003",    color: "#000000", altColor: "#252525" },
    "mastersystem":     { manufacturer: "sega",                 release: "1985",    color: "#A71010", altColor: "#790303" },
    "genesis":          { manufacturer: "sega",                 release: "1988",    color: "#230000", altColor: "#180000" },
    "megadrive":        { manufacturer: "sega",                 release: "1988",    color: "#230000", altColor: "#180000" },
    "gamegear":         { manufacturer: "sega",                 release: "1990",    color: "#0D1114", altColor: "#1F1F1F" },
    "segacd":           { manufacturer: "sega",                 release: "1991",    color: "#010314", altColor: "#02062B" },
    "sega32x":          { manufacturer: "sega",                 release: "1994",    color: "#000000", altColor: "#252525" },
    "saturn":           { manufacturer: "sega",                 release: "1994",    color: "#3B3A9C", altColor: "#292885" },
    "dreamcast":        { manufacturer: "sega",                 release: "1998",    color: "#FB7A33", altColor: "#C0571C" },
    "zxspectrum":       { manufacturer: "sinclair",             release: "1982",    color: "#000000", altColor: "#252525" },
    "vectrex":          { manufacturer: "smith_engineering",    release: "1982",    color: "#000000", altColor: "#252525" },
    "neogeo":           { manufacturer: "snk",                  release: "1990",    color: "#08B5D5", altColor: "#008199" },
    "neogeocd":         { manufacturer: "snk",                  release: "1994",    color: "#000000", altColor: "#252525" },
    "ngp":              { manufacturer: "snk",                  release: "1998",    color: "#93192D", altColor: "#6B0909" },
    "ngpc":             { manufacturer: "snk",                  release: "1999",    color: "#460674", altColor: "#5C056B" },
    "psx":              { manufacturer: "sony",                 release: "1994",    color: "#D9BE36", altColor: "#252525" },
    "ps2":              { manufacturer: "sony",                 release: "2000",    color: "#3144B1", altColor: "#00224C" },
    "psp":              { manufacturer: "sony",                 release: "2004",    color: "#050C10", altColor: "#6A818C" },
    "ps3":              { manufacturer: "sony",                 release: "2006",    color: "#0D1114", altColor: "#1F1F1F" },
    "gog":              { manufacturer: "pc",                   release: "2008",    color: "#000000", altColor: "#252525" },
    "steam":            { manufacturer: "pc",                   release: "2003",    color: "#010314", altColor: "#252525" },
    "arcade":           { manufacturer: null,                   release: null,      color: "#D00E2D", altColor: "#9B071E" },
    "all":              { manufacturer: null,                   release: null,      color: "#FFD019", altColor: "#FF9919" },
    "daphne":           { manufacturer: null,                   release: null,      color: "#000000", altColor: "#252525" },
    "fba":              { manufacturer: null,                   release: null,      color: "#000000", altColor: "#252525" },
    "fbneo":            { manufacturer: null,                   release: null,      color: "#000000", altColor: "#252525" },
    "mame":             { manufacturer: null,                   release: null,      color: "#000000", altColor: "#252525" }
}