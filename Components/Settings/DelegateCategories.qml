import QtQuick 2.15

Item {
    readonly property ListView __lv: ListView.view
    readonly property bool __isCurrentItem: ListView.isCurrentItem
    readonly property bool __isActiveFocus: activeFocus
    readonly property alias axis: rows

    focus: true
    width: __lv.width
    height: __lv.height

    // Rectangle {
    //     anchors.fill: parent
    //     opacity: __isActiveFocus ? 0.05 : 0
    // }

    ListView {
        id: rows
        focus: true

        readonly property bool __isActiveFocus: activeFocus

        anchors.fill: parent

        spacing: vpx(10)

        orientation: ListView.Vertical

        model: modelData.model
        delegate: RowDelegate {}
        highlight: Item {
            Rectangle {
                width: parent.width
                height: vpx(1)
                anchors.bottom: parent.bottom
                color: "white"
                opacity: __isActiveFocus ? 0.1 : 0
            }
        }
        highlightMoveVelocity: -1

    }
}
