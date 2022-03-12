import QtQuick 2.15
import QtQuick.Layouts 1.15

FocusScope {
    // property alias __lv: list
    property bool __isActiveFocus: activeFocus
    property bool dropdownStatus: false

    width: childrenRect.width

    Row {
        id: sortText
        spacing: vpx(5)

        Text {
            id: sortPrefix

            text: "Sort by"
            font {
                family: fontSans.name
                pixelSize: vpx(16)
            }
            opacity: __isActiveFocus ? 1 : 0.2
        }

        Text {
            id: sortLabel
            readonly property var orderString: (librarySorterList.get(currentLibrarySorterIndex).order == 0) ? "asc" : "desc"

            text: librarySorterList.get(currentLibrarySorterIndex).label+" ("+orderString+")"
            font {
                family: fontSans.name
                pixelSize: vpx(16)
            }
            opacity: __isActiveFocus ? 1 : 0.2
        }
    }

    Component {
        id: delegateDropdown

        Rectangle {
            id: background

            readonly property ListView __lv: ListView.view
            readonly property bool __isCurrentItem: ListView.isCurrentItem
            readonly property var icon: (model.order == 0) ? "\ue5c5" : "\ue5c7"

            width: childrenRect.width
            height: __lv.height / __lv.count

            color: "white"

            Row {
                anchors {
                    right: parent.right
                }
                spacing: vpx(5)
                Text {
                    text: model.label
                    color: __isCurrentItem ? "red" : "black"
                    font {
                        family: fontSans.name
                        pixelSize: vpx(16)
                    }
                }

                Row {
                    spacing: vpx(5)
                    Text {
                        text: "ASC"
                        font {
                            family: fontSans.name
                            pixelSize: vpx(16)
                        }
                        opacity: (model.order == 0) ? 1 : 0.2
                    }

                    Text {
                        text: "DESC"

                        font {
                            family: fontSans.name
                            pixelSize: vpx(16)
                        }
                        opacity: (model.order == 1) ? 1 : 0.2
                    }
                }

            }
        }
    }

    // Rectangle {
    //     anchors.fill: list
    //     color: "yellow"
    //     visible: dropdownStatus
    // }

    ListView {
        id: list

        width: contentItem.childrenRect.width
        height: sortText.height * model.count
        anchors {
            top: sortText.bottom
            right: sortText.right
        }

        focus: dropdownStatus
        visible: dropdownStatus

        model: librarySorterList
        delegate: delegateDropdown

        currentIndex: currentLibrarySorterIndex
        onCurrentIndexChanged: {
            currentLibrarySorterIndex = currentIndex
        }

        highlightRangeMode: ListView.ApplyRange

        Keys.onLeftPressed: {
            event.accepted = true
            librarySorterList.setProperty(currentIndex, "order", Qt.AscendingOrder)
        }

        Keys.onRightPressed: {
            event.accepted = true
            librarySorterList.setProperty(currentIndex, "order", Qt.DescendingOrder)
        }

        Keys.onUpPressed: decrementCurrentIndex()

        Keys.onDownPressed: {
            if (0 <= currentIndex < count) {
                incrementCurrentIndex()
            }
            else {
                event.accepted = true
            }
        }
    }

}