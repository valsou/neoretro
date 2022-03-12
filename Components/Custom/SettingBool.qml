import QtQuick 2.15

QtObject {
    property var title
    property var description
    property bool value

    function increment() {
        value = !value
    }

    function decrement() {
        value = !value
    }
}