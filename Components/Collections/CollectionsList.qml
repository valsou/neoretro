import QtQuick 2.15

ListView {
    id: listCollections

    Keys.onPressed: {
        if (event.isAutoRepeat) {
            return
        }

        if (event.key == Qt.Key_Left) {
            event.accepted = true
            decrementCurrentIndex()
        }

        if (event.key == Qt.Key_Right) {
            event.accepted = true
            incrementCurrentIndex()
        }
    }

    focus: true
    clip: false
    displayMarginBeginning: root.width
    displayMarginEnd: root.width

    model: collections
    delegate: CollectionsDelegate {}

    currentIndex: currentCollectionIndex

    Component.onCompleted: {
        positionViewAtIndex(currentIndex, ListView.Beginning)
    }

    onCurrentIndexChanged: {
        currentCollectionIndex = currentIndex
        positionViewAtIndex(currentIndex, ListView.Beginning)
    }

    interactive: false

    orientation: ListView.Horizontal
    highlightRangeMode: ListView.StrictlyEnforceRange

    highlightMoveDuration: 0
    snapMode: ListView.SnapToItem

}