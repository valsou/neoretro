import QtQuick 2.15

QtObject {
    property var title
    property var description
    property int value
    property int min
    property int max

    function increment() {
        if (value+1 <= max) {
            value++
        }
    }

    function decrement() {
        if (value-1 >= min) {
            value--
        }
    }
}