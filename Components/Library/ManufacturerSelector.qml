import QtQuick 2.15

FocusScope {
    id: root
    focus: true

    readonly property bool __isActiveFocus: activeFocus
    property bool dropdownStatus: false

    Rectangle {
        anchors.fill: parent
        color: "white"
        opacity: {
            if (__isActiveFocus) {
                if (dropdownStatus) {
                    return 1
                }
                return 0.4
            }
            return 0
        }
    }

    Rectangle {
        id: leftArrowRect

        states: [
            State {
                name: "pressed"
                PropertyChanges {
                    target: leftArrowRect
                    color: "#1B5C48"
                }
                PropertyChanges {
                    target: leftArrow
                    color: "#06C98C"
                }
            },
            State {
                name: "idle"
                PropertyChanges {
                    target: leftArrowRect
                    color: "#06C98C"
                }
                PropertyChanges {
                    target: leftArrow
                    color: "#1B5C48"
                }
            }
        ]
        state: "default"

        visible: dropdownStatus
        width: vpx(40)
        height: root.height
        anchors {
            top: root.top
            right: root.left
        }

        Text {
            id: leftArrow
            anchors.centerIn: parent
            text: "\uf1e6"
            font {
                family: googleMaterial.name
                pixelSize: vpx(24)
            }
        }
    }

    Rectangle {
        id: rightArrowRect

        states: [
            State {
                name: "pressed"
                PropertyChanges {
                    target: rightArrowRect
                    color: "#1B5C48"
                }
                PropertyChanges {
                    target: rightArrow
                    color: "#06C98C"
                }
            },
            State {
                name: "idle"
                PropertyChanges {
                    target: rightArrowRect
                    color: "#06C98C"
                }
                PropertyChanges {
                    target: rightArrow
                    color: "#1B5C48"
                }
            }
        ]
        state: "default"

        visible: dropdownStatus
        width: vpx(40)
        height: root.height
        anchors {
            top: root.top
            left: root.right
        }

        Text {
            id: rightArrow
            anchors.centerIn: parent
            text: "\uf1df"
            font {
                family: googleMaterial.name
                pixelSize: vpx(24)
            }
        }
    }

    Component {
        id: delegateManufacturer

        Item {
            readonly property ListView __lv: ListView.view
            readonly property bool __isCurrentItem: ListView.isCurrentItem

            width: __lv.width
            height: __lv.height

            Image {
                id: logoManufacturer
                anchors.fill: parent
                sourceSize.width: width
                mipmap: true
                source: "../../assets/collections/logo/"+modelData.shortName+".png"
                fillMode: Image.PreserveAspectFit
            }

            Text {
                visible: logoManufacturer.status !== Image.Ready
                anchors.fill: parent
                text: modelData.name
                font {
                    family: fontSans.name
                    weight: Font.Bold
                    pixelSize: vpx(200)
                }
                minimumPixelSize: vpx(5)
                fontSizeMode: Text.Fit
                horizontalAlignment: Text.AlignHCenter
                color: "black"
            }
        }
    }

    ListView {
        id: manufacturers

        width: parent.width * 0.8
        height: parent.height * 0.7
        anchors.centerIn: parent
        focus: dropdownStatus

        orientation: ListView.Horizontal
        highlightRangeMode: ListView.StrictlyEnforceRange
        highlightMoveDuration: 200
        clip: true

        model: collections

        delegate: delegateManufacturer

        currentIndex: currentCollectionIndex
        onCurrentIndexChanged: currentCollectionIndex = currentIndex
        Component.onCompleted: positionViewAtIndex(currentCollectionIndex, ListView.SnapPosition)

        Keys.onRightPressed: {
            rightArrowRect.state = "pressed"
            incrementCurrentIndex()
        }
        Keys.onLeftPressed: {
            leftArrowRect.state = "pressed"
            decrementCurrentIndex()
        }
        Keys.onReleased: {
            leftArrowRect.state = "idle"
            rightArrowRect.state = "idle"
        }

    }
}