import QtQuick 2.15
import QtQml.Models 2.15
import QtQuick.Layouts 1.15

import "../.."

FocusScope {
    id: root

    property int currentSettingsPage: 0
    property var settings: Variables.settings

    focus: true

    Rectangle {
        anchors.fill: root
        color: "#1C1A34"
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: vpx(30)

        Keys.onPressed: {
            //=> Increment menu index
            if (api.keys.isNextPage(event)) {
                event.accepted = true
                navBar.incrementCurrentIndex()
            }
            //=> Decrement menu index
            if (api.keys.isPrevPage(event)) {
                event.accepted = true
                navBar.decrementCurrentIndex()
            }
        }

        ListView {
            id: navBar

            focus: false

            Layout.preferredWidth: root.width * 0.8
            Layout.preferredHeight: root.height * 0.1
            Layout.alignment: Qt.AlignHCenter

            orientation: ListView.Horizontal

            model: settings
            delegate: NavBarDelegate {}
            highlight: Item {
                Rectangle {
                    width: parent.width
                    height: vpx(1)
                    anchors.bottom: parent.bottom
                    color: "white"
                    opacity: navBar.activeFocus ? 1 : 0
                    Behavior on opacity {
                        NumberAnimation { duration: 200 }
                    }
                }
            }
            highlightRangeMode: ListView.StrictlyEnforceRange
            highlightMoveDuration: 200
            highlightMoveVelocity: 600

            currentIndex: currentSettingsPage
            onCurrentIndexChanged: {
                currentSettingsPage = currentIndex
            }

            Keys.onLeftPressed: decrementCurrentIndex()
            Keys.onRightPressed: incrementCurrentIndex()

            Keys.onDownPressed: {
                focus = false
                settingsList.focus = true
            }
        }

        ListView {
            id: settingsList

            focus: true

            // width: parent.width * 0.7
            // height: parent.height * 0.9

            Layout.preferredWidth: root.width * 0.8
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter

            spacing: root.width * 0.5
            orientation: ListView.Horizontal

            model: settings
            delegate: DelegateCategories {}

            currentIndex: currentSettingsPage
            onCurrentIndexChanged: currentSettingsPage = currentIndex

            //=> Decrement setting value
            Keys.onLeftPressed: settings[currentIndex].model[currentItem.axis.currentIndex].decrement()
            //=> Increment setting value
            Keys.onRightPressed: settings[currentIndex].model[currentItem.axis.currentIndex].increment()
            //=> Increment row OR Focus menu
            Keys.onUpPressed: {
                if (currentItem.axis.currentIndex == 0) {
                    focus = false
                    navBar.focus = true
                }
                else {
                    currentItem.axis.decrementCurrentIndex()
                }
            }
            //=> Decrement row
            Keys.onDownPressed: currentItem.axis.incrementCurrentIndex()

            Keys.onPressed: {
                //=> Increment setting value only if value is a boolean
                if (api.keys.isAccept(event)) {
                    event.accepted = true
                    if (typeof settings[currentIndex].model[currentItem.axis.currentIndex].value == "boolean") {
                        settings[currentIndex].model[currentItem.axis.currentIndex].increment()
                    }
                }
            }

            highlightRangeMode: ListView.StrictlyEnforceRange
            highlightMoveDuration: 200
            highlightMoveVelocity: 600
        }
    }

}