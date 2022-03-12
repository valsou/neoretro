import QtQuick 2.15

import "../.."

ListView {
    id: root
    focus: true

    readonly property real idleTextOpacity: activeFocus ? 0.2 : 0

    /* Interactions */
    Keys.onLeftPressed: decrementCurrentIndex()
    Keys.onRightPressed: incrementCurrentIndex()
    Keys.onPressed: {
        //-> Previous Menu Page
        if (api.keys.isPrevPage(event)) {
            event.accepted = true
            decrementCurrentIndex()
        }
        //-> Next Menu Page
        if (api.keys.isNextPage(event)) {
            event.accepted = true
            incrementCurrentIndex()
        }
    }

    orientation: ListView.Horizontal
    spacing: vpx(25)
    displayMarginBeginning: width
    clip: false
    boundsBehavior: Flickable.StopAtBounds

    model: menuModelProxy

    delegate: MenuDelegate {}

    highlight: Item {
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width + root.spacing
            height: parent.height
            color: "#EFFBF8"
            opacity: root.activeFocus
        }
        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width + root.spacing
            height: parent.height * 0.08
            anchors.top: parent.top
            color: "#06C98C"
        }
    }

    currentIndex: currentMenuIndex
    onCurrentIndexChanged: {
        currentMenuIndex = currentIndex
        syncMenuToPages()
    }

    Component.onCompleted: {
        positionViewAtIndex(currentMenuIndex, ListView.SnapPosition)
    }

    // snapMode: ListView.SnapOneItem
    // highlightFollowsCurrentItem: true
    highlightRangeMode: ListView.StrictlyEnforceRange
    highlightMoveDuration: 200
    highlightMoveVelocity: -1
    highlightResizeDuration : 200
    highlightResizeVelocity : -1

}