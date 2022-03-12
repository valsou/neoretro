import QtQuick 2.15
import QtQuick.Layouts 1.15

RowLayout {

    readonly property int batteryPercent: {
        if (api.device.batteryPercent == "NaN")
            return -1
        else
            return Math.round(api.device.batteryPercent * 100)
    }

    readonly property var batteryStatus: {
        if (api.device.batteryCharging)
            return "\ue1a3" // Charging battery icon
        else if (batteryPercent >= 90)
            return "\ue1a4" // Ful battery icon
        else if (batteryPercent >= 83)
            return "\uebd2" // Battery Level 6 icon
        else if (batteryPercent >= 67)
            return "\uebd4" // Battery Level 5 icon
        else if (batteryPercent >= 50)
            return "\uebe2" // Battery Level 4 icon
        else if (batteryPercent >= 37)
            return "\uebdd" // Battery Level 3 icon
        else if (batteryPercent >= 25)
            return "\uebe0" // Battery Level 2 icon
        else if (batteryPercent >= 12)
            return "\uebd9" // Battery Level 1 icon
        else if (batteryPercent >= 0)
            return "\uebdc" // Battery Level 0 icon
        else
            return "\ue1a6" // Unknown battery icon
    }

    readonly property var batteryColor: {
        if (67 <= batteryPercent <= 100)
            return "green"
        else if (25 <= batteryPercent < 67)
            return "orange"
        else if (0 <= batteryPercent < 25)
            return "red"
        else
            return "grey"
    }

    TextMetrics {
        id: iconMetrics
        text: batteryStatus
        font {
            family: googleMaterial.name
            pixelSize: vpx(22)
        }
    }

    TextMetrics {
        id: valueMetrics
        text: batteryPercent >= 0 ? batteryPercent+"%" : "Unknown"
        font {
            family: regularDosis.name
            styleName: "SemiBold"
            pixelSize: vpx(16)
        }
    }

    Text {
        id: batteryIcon
        text: iconMetrics.text
        font: iconMetrics.font
        color: batteryColor
        Layout.rightMargin: -vpx(6)
    }

    Text {
        id: battery
        text: valueMetrics.text
        font: valueMetrics.font
        color: batteryColor
    }

}