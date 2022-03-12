import QtQuick 2.15

/* Last Game Played */
FocusScope {
    id: recommendations

    focus: true

    Rectangle {
        anchors.fill: parent
        color: "red"

        Text {
            anchors.centerIn: parent
            text: "Recommendations."
        }
    }
}