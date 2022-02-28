import QtQuick 2.15

FocusScope {
    id: root
    anchors.fill: parent
    focus: true
    opacity: 0.5

    Rectangle {
        width: parent.width
        height: parent.height
        color: "yellow"
    }

    Text {
        anchors.centerIn: root
        text: 'focus : '+root.activeFocus
    }
}