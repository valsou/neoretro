import QtQuick 2.15

import "../Global"

Item {
    id: root

    readonly property bool __isCurrentItem: GridView.isCurrentItem
    readonly property GridView __gv: GridView.view

    width: __gv.cellWidth
    height: __gv.cellHeight
    scale: __isCurrentItem && activeFocus ? 1.05 : 1
    Behavior on scale {
        NumberAnimation { duration: 100 }
    }

    // Real card with margins
    Item {
        id: card
        width: parent.width - gamesList.columnSpacing
        height: parent.height - gamesList.rowSpacing
        anchors.centerIn: parent

        Rectangle {
            anchors.fill: parent
            color: Qt.rgba(0.6, 0.6, 0.6)
        }

        Image {
            anchors.fill: parent
            sourceSize.width: width
            source: modelData.assets.screenshot
            fillMode: Image.PreserveAspectCrop
            asynchronous: true

        }

        Rectangle {
            anchors.fill: parent
            color: "black"
            opacity: __isCurrentItem ? 0 : 0.6
        }

        Image {
            width: parent.width * 0.9
            height: parent.height * 0.9
            anchors.centerIn: parent
            sourceSize.width: width
            source: modelData.assets.logo
            fillMode: Image.PreserveAspectFit
            horizontalAlignment : Image.AlignHCenter
            verticalAlignment : Image.AlignVCenter
            asynchronous: true
        }

        Rectangle {
            width: parent.width
            height: parent.height * 0.14
            anchors.bottom: parent.bottom
            color: Qt.rgba(0, 0, 0, 0.6)

            Text {
                width: parent.width * 0.95
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter

                text: __isCurrentItem ? "[X] "+modelData.title : modelData.title
                color: Qt.rgba(0.8, 0.8, 0.8)
                font {
                    family: regularDosis.name
                    pixelSize: vpx(18)
                }
                elide: Text.ElideRight
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }
        }

        Rectangle {
            id: highlightBorder
            anchors.fill: parent
            color: "transparent"
            border {
                width: vpx(3)
                color: "yellow"
            }
            opacity: __isCurrentItem
            SequentialAnimation {
                running: true
                loops: Animation.Infinite
                PropertyAnimation { target: highlightBorder; property: "border.color"; to: "green"; duration: 700; }
                PropertyAnimation { target: highlightBorder; property: "border.color"; to: "yellow"; duration: 1000; }
            }
        }

        PlayButton {
            anchors {
                top: parent.top
                topMargin: -(height / 2)
                right: parent.right
                rightMargin: parent.width * 0.1
            }
            visible: __isCurrentItem
        }

    }

    Item {
        id: extra

        width: card.width
        height: gamesList.rowSpacing
        anchors {
            top: card.bottom
            topMargin: __isCurrentItem ? vpx(3) : 0
            left: card.left
        }

        // Rectangle {
        //     anchors.fill: parent
        //     color: "red"
        // }

        Text {
            anchors.fill: parent
            text: modelData.releaseYear || ""
            font {
                family: regularDosis.name
                styleName: "SemiBold"
                pixelSize: vpx(18)
            }
            color: "red"
        }

    }
}