import QtQuick 2.15
import QtGraphicalEffects 1.15

Item {
    // Fallback colored rectangle
    Rectangle {
        anchors.fill: parent
        color: (assetPrimary.source == "") ? "#BEBEBE" : "transparent"

        // Image missing icon
        Text {
            text: "\uf022"
            font {
                family: googleMaterial.name
                pixelSize: parent.height * 0.7
            }
            color: "#8A8A8A"
            anchors.centerIn: parent
            visible: assetPrimary.source == ""
        }
    }

    // BoxArt or Screenshot
    Image {
        id: assetPrimary
        visible: false
        asynchronous: true

        anchors.fill: parent
        sourceSize.height: height
        mipmap: true

        source: modelData.assets.boxFront
        fillMode: Image.PreserveAspectFit
    }

    Desaturate {
        anchors.fill: assetPrimary
        source: assetPrimary
        desaturation: __isCurrentItem && __isActiveFocus ? 0 : 1.0
        Behavior on desaturation { NumberAnimation { duration: 200 } }
    }
}