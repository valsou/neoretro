import QtQuick 2.15

ListView {
    id: root

    focus: true

    readonly property real idleItemDefaultOpacity: activeFocus ? 0.2 : 0
    property real idleItemOpacity: idleItemDefaultOpacity

    width: ListView.contentWidth
    height: ListView.contentHeight
    orientation: ListView.Horizontal
    spacing: vpx(14)
    displayMarginBeginning: width
    clip: false
    pixelAligned: true

    model: MenuModel {}

    delegate: Text {
        id: menuItem

        text: model.name
        color: textColor
        clip: false

        anchors {
            baseline: parent.bottom
        }

        font.family: regularDosis.name
        font.pixelSize: vpx(30)
        opacity: ListView.isCurrentItem ? 1 : idleItemOpacity
        Behavior on opacity { OpacityAnimator { duration: 200 } }

    }

    highlight: Item {
        width: currentItem.width
        height: currentItem.height

        Text {
            anchors {
                right: parent.left
                bottom: parent.bottom
                bottomMargin: vpx(6)
            }
            // Chevron to the Left
            text: '\ue408'
            font.family: googleMaterial.name
            font.pixelSize: vpx(16)
            opacity: idleItemOpacity == 0 || currentIndex == 0 ? 0 : 1
            Behavior on opacity { OpacityAnimator { duration: 200 } }
        }

        Text {
            anchors {
                left: parent.right
                bottom: parent.bottom
                bottomMargin: vpx(6)
            }
            // Chevron to the Right
            text: '\ue409'
            font.family: googleMaterial.name
            font.pixelSize: vpx(16)
            opacity: idleItemOpacity == 0 || currentIndex == count - 1 ? 0 : 1
            Behavior on opacity { OpacityAnimator { duration: 200 } }
        }

    }

    currentIndex: currentPageIndex
    onCurrentItemChanged: {
        currentPageIndex = currentIndex
    }

    Component.onCompleted: {
        positionViewAtIndex(currentPageIndex, ListView.Visible)
    }

    snapMode: ListView.SnapOneItem
    highlightFollowsCurrentItem: true
    highlightRangeMode: ListView.StrictlyEnforceRange
    highlightMoveDuration: 200
    highlightMoveVelocity: -1
    highlightResizeDuration : 0
    highlightResizeVelocity : -1

}