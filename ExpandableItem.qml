// ExpandableItem.qml
import QtQuick
import Quickshell

Item {
    id: root

    property var barWindow
    property Component popupContent
    property Component iconComponent

    property bool iconHovered: false
    property bool popupHovered: false

    implicitWidth: iconLoader.item ? iconLoader.item.implicitWidth || iconLoader.item.width : 60
    implicitHeight: iconLoader.item ? iconLoader.item.implicitHeight || iconLoader.item.height : 40

    // icon inside the bar
    Loader {
        id: iconLoader
        anchors.centerIn: parent
        sourceComponent: iconComponent
    }

    PopupWindow {
        id: popup
        color: "transparent"

        implicitWidth: popupContent.item ? popupContent.item.implicitWidth : 10
        implicitHeight: popupContent.item ? popupContent.item.implicitHeight : 10

        anchor.window: barWindow   // IMPORTANT: use barWindow, not bar

        visible: iconHovered || popupHovered

        Loader {
            id: popupLoader
            anchors.fill: parent

            sourceComponent: Component {
                RoundedPopupCard {
                    content: Loader {
                        anchors.fill: parent
                        sourceComponent: popupContent  // <--- your popup
                    }
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.NoButton
            propagateComposedEvents: true
            onEntered: popupHovered = true
            onExited: popupHovered = false
        }

        anchor.onAnchoring: {
            var pos = root.mapToItem(barWindow.contentItem, 0, 0);
            anchor.rect.x = barWindow.width- 1;
            anchor.rect.y = pos.y + (root.height - height) / 2;
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
        propagateComposedEvents: true
        onEntered: iconHovered = true
        onExited: iconHovered = false
    }
}
