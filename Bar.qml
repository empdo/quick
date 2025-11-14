// Bar.qml
import Quickshell
import QtQuick
import Quickshell.Hyprland
import Quickshell.Wayland

import "."

Scope {
    property color textColor: "#ebffd9"
    property color backgroundColor: "#1a1a1a"

    PanelWindow {
        id: bar

        exclusiveZone: 0
        color: "transparent"

        anchors {
            top: true
            left: true
            bottom: true
        }
        implicitWidth: 60

        Behavior on implicitWidth {
            NumberAnimation {
                duration: 100
            }
        }

        Row {
            id: mainRow
            anchors.fill: parent
            spacing: 0
            clip: false

            Rectangle {
                id: barArea
                width: 60
                height: parent.height
                color: backgroundColor
                z: 10
                clip: false

                // right border
                Rectangle {
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.right: parent.right
                    width: 1
                    color: textColor
                    opacity: 0.8
                }

                Item {
                    anchors.fill: parent

                    // TOP: workspaces
                    WorkspacesWidget {
                        id: workspaces
                        anchors.top: parent.top
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    // BOTTOM: clock
                    ExpandableItem {
                        id: clockItem
                        barWindow: bar
                        iconComponent: ClockWidget {}
                        popupContent: Component {
                            CalendarPopup {}
                        }

                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    // ABOVE CLOCK: volume
                    ExpandableItem {
                        id: volumeItem
                        barWindow: bar
                        iconComponent: VolumeWidget {}
                        popupContent: Component {
                            VolumePopup {}
                        }

                        anchors.bottom: clockItem.top
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.bottomMargin: 8
                    }
                }
            }
        }
    }
}
