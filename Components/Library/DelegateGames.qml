import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtMultimedia 5.15
import QtGraphicalEffects 1.15

import "../.."
import "../Global"

Item {
    id: root

    Item {
        width: assetWidth
        height: (assetWidth / ratio) + textInfoHeight
        anchors.centerIn: parent

        ColumnLayout {

            id: assetItem

            anchors.fill: parent
            spacing: 0

            Item {
                id: asset

                Layout.preferredWidth: parent.width
                Layout.fillHeight: true

                Loader {
                    anchors.fill: parent
                    asynchronous: false
                    source: {
                        switch (chooseLibraryTypeOfAssets) {
                            case "boxArt":
                                return "ComponentGameCardsBoxart.qml"
                            default:
                                return "ComponentGameCardsDefault.qml"
                        }
                    }
                }
            }

            Item {
                id: info
                Layout.preferredWidth: parent.width * 0.9
                Layout.preferredHeight: textInfoHeight
                Layout.alignment: Qt.AlignHCenter
                visible: textInfoHeight > 0

                ColumnLayout {
                    anchors.fill: parent
                    spacing: 0

                    Item {
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: textInfoHeight / 2

                        /* Game title */
                        Text {
                            width: parent.width
                            height: parent.height * 0.75
                            anchors.baseline: parent.bottom

                            text: modelData.title
                            font {
                                family: fontSans.name
                                pixelSize: height
                            }
                            antialiasing: true
                            maximumLineCount: 1
                            wrapMode: Text.Wrap
                            elide: Text.ElideRight
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            color: "black"
                            // opacity: __isCurrentItem && __isActiveFocus ? 1 : 0
                            // Behavior on opacity { NumberAnimation { duration: 200 } }
                        }

                    }

                    Item {
                        Layout.preferredWidth: parent.width
                        Layout.preferredHeight: textInfoHeight / 2

                        /* Game title */
                        Text {
                            id: extraInfo
                            width: parent.width
                            height: parent.height * 0.75
                            anchors.baseline: parent.bottom

                            text: {
                                switch (librarySorterList.get(currentLibrarySorterIndex).name) {
                                    case "developer":
                                        return modelData.developer || ""
                                    case "publisher":
                                        return modelData.publisher || ""
                                    case "releaseYear":
                                        return modelData.releaseYear || ""
                                    case "genre":
                                        return modelData.genre || ""
                                    case "title":
                                        return modelData.releaseYear || ""
                                    case "players":
                                        return modelData.players || ""
                                    case "rating":
                                        return Math.round(modelData.rating * 5)+"/5" || ""
                                    default:
                                        return modelData.releaseYear || ""
                                }
                            }
                            font {
                                family: fontSans.name
                                weight: Font.DemiBold
                                pixelSize: height
                            }
                            antialiasing: true
                            maximumLineCount: 1
                            wrapMode: Text.Wrap
                            elide: Text.ElideRight
                            horizontalAlignment: Text.AlignHCenter
                            color: "black"
                            // opacity: __isCurrentItem && __isActiveFocus ? 1 : 0
                            // Behavior on opacity { NumberAnimation { duration: 200 } }
                        }

                    }

                }

            }

        }
    }


}