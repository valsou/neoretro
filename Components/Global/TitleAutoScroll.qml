import QtQuick 2.8

/// This item provides an infinitely looping, autoscrolling view into
/// a taller content.
/// You can change the scrolling speed (pixels per second), and the
/// additional delay before and after the the animation.
/// If the content fits into the view, no scrolling happens.
Flickable {
    id: container

    property int scrollWaitDuration: 3000
    property int pixelsPerSecond: 26

    function stopScroll() {
        scrollAnimGroup.complete();
    }
    function restartScroll() {
        scrollAnimGroup.restart();
    }

    clip: true
    flickableDirection: Flickable.VerticalFlick
    contentWidth: contentItem.childrenRect.width
    contentHeight: height

    property int targetX: Math.max(contentWidth - width, 0);

    function recalcAnimation() {
        scrollAnimGroup.stop();
        contentX = 0;

        // the parameters of the sub-animations can't be properly
        // changed by regular binding while the group is running
        animScrollDown.to = targetX;
        animScrollDown.duration = (targetX / pixelsPerSecond) * 1000;
        animPauseHead.duration = scrollWaitDuration;
        animPauseTail.duration = scrollWaitDuration;

        scrollAnimGroup.restart();
    }
    onTargetXChanged: recalcAnimation()
    onScrollWaitDurationChanged: recalcAnimation()
    onPixelsPerSecondChanged: recalcAnimation()

    // cancel the animation on user interaction
    onMovementStarted: scrollAnimGroup.stop()

    SequentialAnimation {
        id: scrollAnimGroup
        running: true
        loops: Animation.Infinite

        PauseAnimation {
            id: animPauseHead
            duration: 0
        }
        NumberAnimation {
            id: animScrollDown
            target: container; property: "contentX"
            from: 0; to: 0; duration: 0
        }
        PauseAnimation {
            id: animPauseTail
            duration: 0
        }
        NumberAnimation {
            target: container; property: "contentX"
            to: 0; duration: 1000
        }
    }
}