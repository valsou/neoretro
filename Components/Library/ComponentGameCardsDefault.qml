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

        source: modelData.assets.screenshot
        fillMode: Image.PreserveAspectCrop
    }

    Desaturate {
        anchors.fill: assetPrimary
        source: assetPrimary
        desaturation: __isCurrentItem && __isActiveFocus ? 0 : 1.0
        Behavior on desaturation { NumberAnimation { duration: 200 } }
    }

    // Logo
    Image {
        id: assetLogo
        asynchronous: true
        anchors.fill: parent
        source: modelData.assets.logo
        fillMode: Image.PreserveAspectFit
        scale: __isCurrentItem ? 0.75 : 0.6
        Behavior on scale { NumberAnimation { duration: 200 } }
        mipmap: true
    }

}