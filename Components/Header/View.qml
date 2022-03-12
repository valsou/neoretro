import QtQuick 2.15
import QtQuick.Layouts 1.15

FocusScope {
    id: root

    property alias aliasMenu: menuList
    // Rectangle {
    //     anchors.fill: parent
    //     color: "yellow"

    //     Text {
    //         anchors.centerIn: parent
    //         text: "Header"
    //         font {
    //             pixelSize: vpx(50)
    //         }
    //     }
    // }

    // onActiveFocusChanged: {
    //     if (enableCollectionsPage == false) {
    //         if (menuList.count == 4) {
    //             menuList.model.remove(2)
    //         }
    //     }
    //     else {
    //         if (menuList.count == 3) {
    //             menuList.model.insert(2, { name: "Collections" })
    //         }
    //     }
    // }

    Rectangle {
        anchors.fill: parent
        color: "#FDFDFD"
    }

    RowLayout {
        id: items

        width: parent.width * 0.8
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter


        Menu {
            id: menuList
            focus: true
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height
            Layout.alignment: Qt.AlignVCenter
            // Layout.bottomMargin: vpx(6)
        }

        Battery {
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.preferredHeight: parent.height
            // Layout.rightMargin: vpx(15)
            // Layout.bottomMargin: vpx(3)
            visible: enableBatteryStatus
        }

        Time {
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.preferredHeight: parent.height
            // Layout.bottomMargin: vpx(3)
        }
    }

}