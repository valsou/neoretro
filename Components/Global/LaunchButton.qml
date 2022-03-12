import QtQuick 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root

    property bool focused
    property var label
    property real size

    states: [
        State {
            name: "focus"
            PropertyChanges {
                target: arrow
                anchors.rightMargin: vpx(5)
            }
            PropertyChanges {
                target: root
                opacity: 1
            }
        },
        State {
            name: "notFocus"
            PropertyChanges {
                target: arrow
                anchors.rightMargin: vpx(25)
            }
            PropertyChanges {
                target: root
                opacity: 0
            }
        }
    ]

    transitions: Transition {
        from: "*"
        to: "*"
        NumberAnimation { properties:"opacity"; duration: 200 }
        NumberAnimation { properties:"anchors.rightMargin"; easing.type: Easing.InOutQuad; duration: 500 }
    }

    state: focused ? "focus" : "notFocus"

    width: text.width * 1.46
    height: text.height * 1.35

    color: "#00D06C"

    Item {
        id: text
        width: childrenRect.width
        height: childrenRect.height
        anchors {
            right: parent.right
            rightMargin: parent.width * 0.1
            verticalCenter: parent.verticalCenter
        }

        Text {
            text: label
            color: "#006233"
            font {
                family: fontSans.name
                weight: Font.ExtraBold
                pixelSize: size
            }
        }
    }

    Text {
        id: arrow
        anchors {
            right: text.left
            verticalCenter: text.verticalCenter
        }
        text: "\uf1df"
        color: "#006233"
        font {
            family: googleMaterial.name
            pixelSize: size * 1.5
        }
    }

}