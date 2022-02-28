import QtQuick 2.15

FocusScope {
    id: root

    focus: true
    anchors.fill: parent

    function settingModifier(index, operation) {
        var value = settings.get(index).value

        switch (typeof value) {
            case "boolean":
                value = !value
                break;
            case "number":
                if (operation == "increment") {
                    value++
                }
                else if (operation == "decrement") {
                    value --
                }
                break;
            default:
                break
        }

        settings.setProperty(index, "value", value)
    }

    Rectangle {
        width: parent.width
        height: parent.height
        color: backgroundColor
        opacity: 0.1
    }



    ListModel {
        id: settings

        dynamicRoles: true

        // Workaround to use properties binding inside ListModel elements
        // https://stackoverflow.com/questions/7659442/listelement-fields-as-properties
        Component.onCompleted: {
            append({
                category: "General",
                description: "Enable dark theme",
                value: darkTheme,
                apiString: "darkTheme"
            })
            append({
                category: "Collections",
                description: "Generate \"All\" games collection",
                value: showAllGamesCollection,
                apiString: "showAllGamesCollection"
            })
            append({
                category: "Collections",
                description: "Generate \"Favorites\" games collection",
                value: showFavoritesCollection,
                apiString: "showFavoritesCollection"
            })
            append({
                category: "Collections",
                description: "Generate \"LastPlayed\" games collection",
                value: showLastPlayedCollection,
                apiString: "showLastPlayedCollection"
            })
            append({
                category: "Games",
                description: "Number of columns",
                value: gridColumns,
                apiString: "gamesGridColumns"
            })
            append({
                category: "Games",
                description: "Number of rows",
                value: gridRows,
                apiString: "gamesGridRows"
            })
        }
    }

    ListView {
        id: settingsList
        focus: true

        anchors.fill: parent

        highlightRangeMode: ListView.ApplyRange

        model: settings

        section.property: "category"
        section.criteria: ViewSection.FullString
        section.delegate: Text {
            color: textColor
            font {
                family: regularDosis.name
                styleName: "Bold"
                pixelSize: vpx(24)
            }
            text: section
        }

        delegate: RowSettings {}
        highlight: Rectangle {
            color: "white"
            opacity: 0.25
        }
        highlightMoveVelocity: -1

        Keys.onRightPressed: {
            settingModifier(currentIndex, "increment")
        }
        Keys.onLeftPressed: {
            settingModifier(currentIndex, "decrement")
        }

    }

    Component.onDestruction: {
        for (let i = 0; i < settings.count; i++) {
            api.memory.set(settings.get(i).apiString, settings.get(i).value)
        }
    }

}