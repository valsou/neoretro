import QtQuick 2.15

// import "../Global"

ListView {
    orientation: ListView.Horizontal

    model: modelData.games

    delegate: HomeGameDelegate {}
}