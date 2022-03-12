import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtMultimedia 5.15

import "../Global"
import "../.."
import "../../utils.js" as Utils
import "qrc:/qmlutils" as PegasusUtils

FocusScope {
    id: root
    focus: true

    readonly property bool __isActiveFocus: activeFocus
    property var lastGame: api.allGames.get(ProxyGameModels.recentlyPlayedModel.mapToSource(0))
    readonly property var assetsModel: {
        let array = []
        let background = lastGame.assets.background || ""
        let screenshot = lastGame.assets.screenshot || ""
        let logo = lastGame.assets.logo || ""
        let titlescreen = lastGame.assets.titlescreen || ""
        let video = lastGame.assets.video || ""

        if (background) {
            array.push({ type: "background", assets: lastGame.assets })
        }

        if (video) {
            array.push({ type: "video", assets: lastGame.assets })
        }

        if (screenshot) {
            array.push({ type: "screenshot", assets: lastGame.assets })
        }

        if (logo) {
            array.push({ type: "logo", assets: lastGame.assets })
        }

        if (titlescreen) {
            array.push({ type: "titlescreen", assets: lastGame.assets })
        }

        return array
    }

    property int currentAssetIndex: 0

    Keys.onPressed: {
        if (api.keys.isAccept(event)) {
            event.accepted = true
            launchGame(lastGame)
        }

        if (api.keys.isDetails(event)) {
            event.accepted = true
            lastGame.favorite = !lastGame.favorite
        }
    }

    // scale: __isActiveFocus ? 1 : 0.97
    // Behavior on scale { NumberAnimation { duration: 300 } }

    Image {
        id: shadow
        width: root.width
        height: root.height * 0.1
        anchors {
            top: root.bottom
            topMargin: __isActiveFocus ? -vpx(15) : -vpx(30)
        }
        opacity: __isActiveFocus ? 0.4 : 0
        Behavior on opacity { NumberAnimation { duration: 700 } }
        source: "../../assets/shadow.png"
    }

    Rectangle {
        anchors.fill: card
        color: "white"
    }


    Item {
        width: parent.width
        height: parent.height * 0.09

        Text {
            width: parent.width
            height: parent.height * 0.7
            text: "CONTINUE PLAYING"
            font {
                family: fontSans.name
                pixelSize: height
                weight: Font.Light
            }
            verticalAlignment: Text.AlignBottom
        }
    }


    /* Level 1
    => Cut in half horizontally
    */
    RowLayout {
        id: card
        width: parent.width
        height: parent.height * 0.91
        anchors.bottom: parent.bottom

        spacing: 0

        Item {
            id: assets
            Layout.preferredWidth: parent.width * 0.48
            Layout.preferredHeight: parent.height

            ListView {
                id: assetsList
                focus: true
                anchors.fill: parent

                onActiveFocusChanged: {
                    if (assetsModel[currentIndex].type == "video") {
                        currentItem.video.pause()
                    }
                }

                Keys.onLeftPressed: {
                    if (assetsModel[currentIndex].type == "video") {
                        currentItem.video.pause()
                    }
                    decrementCurrentIndex()
                }
                Keys.onRightPressed: {
                    if (assetsModel[currentIndex].type == "video") {
                        currentItem.video.pause()
                    }
                    incrementCurrentIndex()
                }
                Keys.onPressed: {
                    if (assetsModel[currentIndex].type == "video") {
                        if (api.keys.isDetails(event)) {
                            event.accepted = true
                            if (currentItem.video.playbackState == MediaPlayer.PlayingState) {
                                currentItem.video.pause()
                            }
                            else {
                                currentItem.video.play()
                            }
                        }

                        if (api.keys.isFilters(event)) {
                            event.accepted = true
                            currentItem.video.muted = !currentItem.video.muted
                        }
                    }
                }

                clip: true
                visible: __isActiveFocus

                orientation: ListView.Horizontal
                highlightMoveDuration: 200
                displayMarginBeginning: width * (count - 1)
                displayMarginEnd: width * (count - 1)

                model: assetsModel
                delegate: DelegateAssetsLastGamePlayed {}

                currentIndex: currentAssetIndex
                onCurrentIndexChanged: {
                    currentAssetIndex = currentIndex
                    if (assetsModel[currentIndex].type == "video") {
                        if (currentItem.video.playbackState == MediaPlayer.StoppedState) {
                            currentItem.video.play()
                        }
                    }
                }
            }

            Desaturate {
                anchors.fill: assetsList
                source: assetsList
                visible: !__isActiveFocus
                desaturation: __isActiveFocus ? 0 : 1.0
                Behavior on desaturation { NumberAnimation { duration: 200 } }
            }

            ListView {
                width: parent.width * 0.22
                height: parent.height * 0.02
                anchors {
                    top: parent.bottom
                    topMargin: vpx(15)
                    left: parent.left
                }

                clip: true
                opacity: __isActiveFocus

                orientation: ListView.Horizontal
                highlightMoveDuration: 200

                model: assetsModel
                delegate: DelegateAssetsNavbarLastGamePlayed {}

                currentIndex: currentAssetIndex
            }

            LaunchButton {
                label: "RESUME"
                size: vpx(18)
                focused: __isActiveFocus
                anchors {
                    top: parent.bottom
                    right: parent.right
                }
            }

        }

        Item {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height

            /* Level 2
            => Cut right part in 2
            */
            ColumnLayout {
                anchors.centerIn: parent
                width: parent.width * 0.9
                height: parent.height * 0.85
                spacing: 0

                Item {
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: parent.height * 0.76

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 0

                        /* Title */
                        Item {
                            Layout.preferredWidth: parent.width
                            Layout.preferredHeight: parent.height * 0.2655
                            // Rectangle {
                            //     anchors.fill: parent
                            //     color: "silver"
                            //     border {
                            //         width: vpx(1)
                            //         color: "grey"
                            //     }
                            // }

                            Text {
                                id: textTitle
                                anchors.fill: parent

                                text: lastGame.title
                                font {
                                    family: fontSans.name
                                    weight: Font.Bold
                                    pixelSize: textTitle.height / 2
                                }
                                lineHeight: 0.7
                                color: "black"
                                maximumLineCount: 2
                                wrapMode: Text.WordWrap
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignBottom // BUG: Alignment is inverted (why ?)
                            }
                        }

                        /* Release year */
                        Item {
                            Layout.preferredWidth: parent.width
                            Layout.preferredHeight: parent.height * 0.1515
                            // Rectangle {
                            //     anchors.fill: parent
                            //     color: "silver"
                            //     border {
                            //         width: vpx(1)
                            //         color: "grey"
                            //     }
                            // }

                            Text {
                                id: textReleaseYear
                                width: parent.width
                                height: parent.height * 0.7

                                text: lastGame.releaseYear
                                font {
                                    family: fontSans.name
                                    weight: Font.Light
                                    pixelSize: textReleaseYear.height
                                }
                                color: "black"
                                verticalAlignment: Text.AlignVCenter // BUG: Alignment is inverted (why ?)
                            }
                        }

                        /* Developer & publisher */
                        Item {
                            Layout.preferredWidth: parent.width
                            Layout.preferredHeight: parent.height * 0.095
                            // Rectangle {
                            //     anchors.fill: parent
                            //     color: "silver"
                            //     border {
                            //         width: vpx(1)
                            //         color: "grey"
                            //     }
                            // }

                            Text {
                                id: textDeveloper
                                width: parent.width
                                height: parent.height * 0.75

                                readonly property var developer: {
                                    if (lastGame.developer == lastGame.publisher) {
                                        return "Developed and published by <b>"+lastGame.developer+"</b>"
                                    }
                                    else {
                                        return "Developed by <b>"+lastGame.developer+"</b> · Published by <b>"+lastGame.publisher+"</b>"
                                    }
                                }

                                text: developer
                                font {
                                    family: fontSans.name
                                    weight: Font.Light
                                    pixelSize: textDeveloper.height
                                }
                                color: "black"
                                wrapMode: Text.WordWrap
                                elide: Text.ElideRight
                                verticalAlignment: Text.AlignVCenter // BUG: Alignment is inverted (why ?)
                            }
                        }

                        /* Players & genres */
                        Item {
                            Layout.preferredWidth: parent.width
                            Layout.preferredHeight: parent.height * 0.099

                            Row {
                                anchors.fill: parent
                                spacing: vpx(8)

                                LabelPlayers {
                                    anchors.verticalCenter: parent.verticalCenter
                                    size: parent.height * 0.5
                                    players: lastGame.players
                                }

                                Repeater {
                                    model: lastGame.genreList
                                    delegate: LabelGenres {
                                        anchors.verticalCenter: parent.verticalCenter
                                        size: parent.height * 0.5
                                        genre: modelData
                                    }
                                }


                            }
                        }

                        /* Summary & description */
                        Item {
                            Layout.preferredWidth: parent.width
                            Layout.preferredHeight: parent.height * 0.389
                            // Rectangle {
                            //     anchors.fill: parent
                            //     color: "silver"
                            //     border {
                            //         width: vpx(1)
                            //         color: "grey"
                            //     }
                            // }

                            Text {
                                id: textSummary
                                width: parent.width
                                height: parent.height * 0.8
                                anchors.centerIn: parent

                                text: lastGame.summary || lastGame.description
                                font {
                                    family: fontSans.name
                                    pixelSize: textSummary.height / textSummary.maximumLineCount
                                }
                                lineHeight: 0.7
                                color: "black"
                                maximumLineCount: 5
                                wrapMode: Text.WordWrap
                                elide: Text.ElideRight
                                horizontalAlignment: Text.AlignJustify
                                verticalAlignment: Text.AlignBottom
                            }
                        }
                    }
                }

                /* Separator */
                Item {
                    Layout.preferredWidth: parent.width * 0.6
                    Layout.preferredHeight: parent.height * 0.09
                    Layout.alignment: Qt.AlignHCenter

                    Rectangle {
                        width: parent.width
                        height: vpx(1)
                        anchors.centerIn: parent
                        color: "#F3F3F3"
                    }
                }

                Item {
                    Layout.preferredWidth: parent.width
                    Layout.fillHeight: true

                    /* Level 3
                    => Cut lower part in 3 (Last played, Play time & Rating)
                    */
                    RowLayout {
                        anchors.fill: parent
                        spacing: 0

                        // Last played
                        Item {
                            Layout.preferredWidth: parent.width / 3
                            Layout.fillHeight: true

                            ColumnLayout {
                                anchors.fill: parent
                                spacing: 0

                                Column {
                                    Layout.preferredWidth: parent.width
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                                    Text {
                                        width: parent.width
                                        height: contentHeight
                                        text: "Last played"
                                        font {
                                            family: fontSans.name
                                            weight: Font.Light
                                            pixelSize: vpx(18)
                                        }
                                        color: "#BDBDBD"
                                        horizontalAlignment: Text.AlignHCenter
                                    }

                                    Text {
                                        width: parent.width
                                        height: contentHeight
                                        text: Utils.formatLastPlayed(lastGame.lastPlayed)
                                        font {
                                            family: fontSans.name
                                            weight: Font.DemiBold
                                            pixelSize: vpx(16)
                                        }
                                        color: "#434343"
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                }


                            }
                        }

                        // Play time
                        Item {
                            Layout.preferredWidth: parent.width / 3
                            Layout.fillHeight: true

                            ColumnLayout {
                                anchors.fill: parent
                                spacing: 0

                                Column {
                                    Layout.preferredWidth: parent.width
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                                    Text {
                                        width: parent.width
                                        height: contentHeight
                                        text: "Play time"
                                        font {
                                            family: fontSans.name
                                            weight: Font.Light
                                            pixelSize: vpx(18)
                                        }
                                        color: "#BDBDBD"
                                        horizontalAlignment: Text.AlignHCenter
                                    }

                                    Text {
                                        width: parent.width
                                        height: contentHeight
                                        text: Utils.formatPlayTime(lastGame.playTime)
                                        font {
                                            family: fontSans.name
                                            weight: Font.DemiBold
                                            pixelSize: vpx(16)
                                        }
                                        color: "#434343"
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                }


                            }
                        }

                        // Rating
                        Item {
                            Layout.preferredWidth: parent.width / 3
                            Layout.fillHeight: true

                            ColumnLayout {
                                anchors.fill: parent
                                spacing: 0

                                Column {
                                    Layout.preferredWidth: parent.width
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                                    Text {
                                        width: parent.width
                                        height: contentHeight
                                        text: "Rating"
                                        font {
                                            family: fontSans.name
                                            weight: Font.Light
                                            pixelSize: vpx(18)
                                        }
                                        color: "#BDBDBD"
                                        horizontalAlignment: Text.AlignHCenter
                                    }

                                    Row {
                                        anchors.horizontalCenter: parent.horizontalCenter

                                        spacing: vpx(3)

                                        Text {
                                            width: contentWidth
                                            height: contentHeight
                                            anchors.bottom: rating.bottom
                                            anchors.bottomMargin: vpx(3)
                                            text: "\ue838"
                                            font {
                                                family: googleMaterial.name
                                                pixelSize: vpx(16)
                                            }
                                            color: "#FFC500"
                                        }

                                        Text {
                                            id: rating
                                            width: contentWidth
                                            height: contentHeight
                                            text: (lastGame.rating * 5).toFixed(1)
                                            font {
                                                family: fontSans.name
                                                weight: Font.DemiBold
                                                pixelSize: vpx(16)
                                            }
                                            color: "#434343"
                                        }
                                    }

                                }


                            }
                        }

                    }
                }
            }
        }
    }

}