import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

import "../.."
import "../../collectionsData.js" as CollectionsData
import "qrc:/qmlutils" as PegasusUtils

FocusScope {
    id: root
    focus: true
    // readonly property var manufacturer: Consoles.getManufacturer(currentCollection.shortName)
    // readonly property var consoles: Consoles.data
    // readonly property var system: consoles[currentCollection.shortName]
    readonly property var collectionData: CollectionsData.get[currentCollection.shortName] || ""

    Rectangle {
        anchors.fill: parent
        color: "yellow"
        opacity: 0.3
    }

    /* Top Division */
    Item {
        id: top
        height: parent.height * 0.3
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
        }
    }

    /* Collection release year */
    Text {
        id: collectionRelease

        clip: true

        anchors {
            left: collectionsList.left
            // rightMargin: - collectionsList.width * 0.54
            bottom: collectionsList.top
        }
        text: Consoles.releaseDate(currentCollection.shortName) || ""
        font.family: fontSans.name
        font.styleName: "SemiBold"
        font.pixelSize: vpx(175)
        lineHeight: 0.77
        color: Consoles.primaryColor(currentCollection.shortName) || textColor

        ParallelAnimation {
            id: animateCollectionRelease

            alwaysRunToEnd: true
            running: true
            // NumberAnimation {
            //     target: collectionRelease;
            //     property: "anchors.bottomMargin";
            //     from: -vpx(100);
            //     to: -vpx(60);
            //     duration: 400
            // }
            NumberAnimation {
                target: collectionRelease;
                property: "opacity";
                from: 0;
                to: 1;
                duration: 800
            }
        }

    }

    /* Collection description/summary */
    PegasusUtils.AutoScroll {
        id: collectionSummary
        width: collectionsList.width * 0.44
        height: collectionsList.height * 0.3

        anchors {
            right: root.right
            top: collectionsList.top
            topMargin: collectionsList.height * 0.12
        }

        Text {
            width: parent.width
            text:   currentCollection.summary ||
                    currentCollection.description ||
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

    /* Collections */
    CollectionsList {
        id: collectionsList

        height: parent.height * 0.6
        anchors {
            left: parent.left
            right: parent.right
            top: top.bottom
        }

        onCurrentIndexChanged: {
            collectionSummary.recalcAnimation()
            animateGo.restart()
            animateCollectionRelease.restart()
        }
    }

    Go {
        id: go
        anchors {
            bottom: collectionsList.bottom
            bottomMargin: vpx(15)
            left: collectionsList.left
            leftMargin: collectionsList.width * 0.5
        }

        ParallelAnimation {
            id: animateGo

            alwaysRunToEnd: true
            running: true
            NumberAnimation {
                target: go;
                property: "anchors.leftMargin";
                from: collectionsList.width * 0.4;
                to: collectionsList.width * 0.5;
                duration: 200
            }
            NumberAnimation {
                target: go;
                property: "opacity";
                from: 0;
                to: 1;
                duration: 400
            }
        }

    }

    /* Collection logo */
    Item {
        width: root.width * 0.52
        height: collectionsList.height * 0.35

        anchors {
            right: root.right
            bottom: collectionsList.top
            bottomMargin: - (parent.height * 0.015)
        }

        /* Rectangle/separator */
        // Rectangle {
        //     width: collectionName.width * 0.4
        //     height: vpx(7)
        //     radius: width / 2

        //     anchors {
        //         top: collectionName.bottom
        //         topMargin: vpx(10)
        //         left: collectionName.left
        //     }

        //     color: Qt.rgba(backgroundColor.r, backgroundColor.g, backgroundColor.b, 0.45)
        // }

        Item {
            id: collectionName

            width: parent.width * 0.7
            height: parent.height

            Text {
                width: parent.width
                height: parent.height
                anchors.baseline: parent.bottom

                text: currentCollection.name
                color: enableDarkTheme ? textColor : collectionData.color || textColor
                font.family: regularDosis.name
                font.styleName: "Bold"
                fontSizeMode: Text.Fit
                minimumPixelSize: vpx(5)
                font.pixelSize: vpx(200)
                opacity: (collectionLogo.status == Image.Error)
                Behavior on opacity { OpacityAnimator { duration: 300 } }
            }

            Image {
                id: collectionLogo
                anchors.fill: parent
                asynchronous: true
                sourceSize.width: parent.width
                source: enableDarkTheme   ? "../../assets/collections/logo/"+currentCollection.shortName+"_bw.png"
                                    : "../../assets/collections/logo/"+currentCollection.shortName+".png"
                fillMode: Image.PreserveAspectFit
                // mipmap: true
                verticalAlignment: Image.AlignBottom
                opacity: (status == Image.Ready)
                Behavior on opacity { OpacityAnimator { duration: 300 } }
            }
        }

        Item {
            id: collectionGamesCount

            width: parent.width * 0.3
            height: parent.height
            anchors.right: parent.right

            /* Number of games in the collection with border outisde */
            CountGames {
                anchors {
                    right: parent.right
                    bottom: parent.bottom
                }
            }

        }

    }

    // /* Manufacturer logo */
    Item {
        width: vpx(90)
        height: vpx(50)
        anchors {
            top: collectionsList.bottom
            topMargin: -(height / 2)
            left: collectionsList.left
            leftMargin: vpx(45)
        }

        Rectangle {
            // color: collectionData.color || textColor
            color: Manufacturers.primaryColor(Consoles.manufacturer(currentCollection.shortName))
            anchors.centerIn: manufacturerLogo
            width: manufacturerLogo.paintedWidth + vpx(15)
            height: manufacturerLogo.paintedHeight + vpx(20)
            visible: manufacturerLogo.status == Image.Ready

            Behavior on height {
                NumberAnimation { duration: 150 }
            }
        }

        Image {
            id: manufacturerLogo
            anchors.fill: parent
            sourceSize.width: width
            asynchronous: true
            source: "../../assets/manufacturers/logo/"+Consoles.manufacturer(currentCollection.shortName)+".svg" || ""
            fillMode: Image.PreserveAspectFit
            mipmap: true
            smooth: true
        }

        /* TODO : Fallback with Text instead of image */
        /**********************************************/
    }

    /* Helper nav */
    Item {
        id: bottom
        height: parent.height * 0.1
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        Rectangle {
            anchors {
                left: parent.left
                right: parent.right
                bottom: parent.bottom
                bottomMargin: vpx(10)
            }
            height: vpx(2)
            color: Qt.rgba(textColor.r, textColor.g, textColor.b, 0.1)

            Rectangle {
                id: navBar
                x: width * currentCollectionIndex
                width: parent.width / collectionsList.count
                height: parent.height
                color: Qt.rgba(textColor.r, textColor.g, textColor.b, 0.2)
            }

        }

    }

}