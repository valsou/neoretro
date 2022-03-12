import QtQuick 2.15
import QtQuick.Layouts 1.15
import "qrc:/qmlutils" as PegasusUtils

Item {

    Rectangle {
        anchors.fill: parent
        color: "yellow"
        opacity: 0.3
    }

    Item {
        width: parent.width * 0.5
        height: parent.height

        ColumnLayout {
            Text {
                text: (currentGame.rating *5).toFixed(1)+"/5"
                font {
                    family: regularDosis.name
                    styleName: "SemiBold"
                    pixelSize: vpx(26)
                }
            }

            // Favorited
            Text {
                text: currentGame.favorite ? "LIKED" : ""
                font {
                    family: regularDosis.name
                    styleName: "SemiBold"
                    pixelSize: vpx(26)
                }
                color: "red"
            }

            Text {
                text: currentGame.title
                font {
                    family: regularDosis.name
                    styleName: "SemiBold"
                    pixelSize: vpx(26)
                }
            }

            Rectangle {
                width: vpx(65)
                height: vpx(3)
                radius: width
                color: textColor
                opacity: 0.3
            }

            Text {
                text: "Developed by "+currentGame.developer
                font {
                    family: regularDosis.name
                    pixelSize: vpx(16)
                }
            }
        }


        PegasusUtils.AutoScroll {
            width: parent.width
            height: parent.height * 0.3
            anchors.bottom: parent.bottom

            Text {
                anchors.fill: parent
                text:   currentGame.summary ||
                        currentGame.description ||
                        ""
                font {
                    family: global.fonts.sans
                    styleName: "Light"
                    pixelSize: vpx(16)
                }
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignJustify
                color: textColor
                opacity: (text != "")
            }
        }
    }

    Item {
        width: parent.width * 0.4
        height: parent.height
        anchors.right: parent.right

        Rectangle {
            anchors.fill: parent
            color: "red"
        }

        // Release date
        Item {
            width: parent.width
            height: parent.height * 0.4
            anchors.top: parent.top

            Rectangle {
                anchors.fill: parent
                color: "green"
                opacity: 0.2
            }

            Text {
                width: parent.width
                text:   currentGame.releaseYear ||
                        ""
                font {
                    family: regularDosis.name
                    pixelSize: parent.height * 0.7
                }
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignJustify
                color: textColor
                opacity: (text != "")
            }
        }

        // Asset
        Item {
            width: parent.width
            height: parent.height * 0.8
            anchors.bottom: parent.bottom

            Rectangle {
                anchors.fill: parent
                color: "silver"
                opacity: 1
            }

            Image {
                anchors.fill: parent
                sourceSize.width: width
                source: currentGame.assets.boxFront
                fillMode: Image.PreserveAspectFit
            }
        }

    }


}