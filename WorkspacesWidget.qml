import QtQuick
import QtQuick.Shapes
import Quickshell
import Quickshell.Hyprland

Item {
    anchors.fill: parent

    Column {
        id: content
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.fill: parent
        spacing: 12

        // Arch logo
        Text {
            text: "󰣇"
            color: "#ebffd9"
            rightPadding: 5
            topPadding: 8
            font.pixelSize: 30
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        // Workspaces background
        Rectangle {
            id: repeaterBackground
            color: "#1a1a1a"
            radius: 20
            border.color: "#ebffd9"
            border.width: 1
            width: 28
            height: repeaterRow.implicitHeight + 16
            anchors.horizontalCenter: parent.horizontalCenter
            clip: true

            Column {
                id: repeaterRow
                anchors.centerIn: parent
                spacing: 8
                padding: 8

                Repeater {
                    model: Hyprland.workspaces

                    delegate: Rectangle {
                        width: 12
                        height: 12
                        radius: 6
                        color: modelData.active ? "#ebffd9" : "transparent"
                        border.color: "#ebffd9"
                        border.width: 2
                        anchors.horizontalCenter: parent.horizontalCenter

                        MouseArea {
                            anchors.fill: parent
                            onClicked: modelData.activate()
                            hoverEnabled: true
                        }
                    }
                }
            }
        }
    }
}
