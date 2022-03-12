import QtQuick 2.15

QtObject {
    property var title
    property var description
    property var value
    property var possibilities

    property int index: possibilities.indexOf(value)

    function increment() {
        if (possibilities[index+1]) {
            value = possibilities[index+1]
        }
    }

    function decrement() {
        if (possibilities[index-1]) {
            value = possibilities[index-1]
        }
    }
}