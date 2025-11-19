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

    property bool smoothBottom

    implicitWidth: iconLoader.item ? iconLoader.item.implicitWidth || iconLoader.item.width : 60
    implicitHeight: iconLoader.item ? iconLoader.item.implicitHeight || iconLoader.item.height : 40

    // icon inside the bar
    Loader {
        id: iconLoader
        anchors.centerIn: parent
        sourceComponent: iconComponent

        scale: popup.visible ? 1.1 : 1.0

        Behavior on scale {
            NumberAnimation {
                duration: 150
                easing.type: Easing.OutCubic
            }
        }
    }

    PopupWindow {
        id: popup
        color: "transparent"

        implicitWidth: popupLoader.item ? popupLoader.item.implicitWidth : 260
        implicitHeight: popupLoader.item ? popupLoader.item.implicitHeight : 100

        anchor.window: barWindow

        visible: iconHovered || popupHovered

        Loader {
            id: popupLoader

            sourceComponent: Component {
                RoundedPopupCard {
                    id: card
                    smoothBottom: root.smoothBottom

                    // Animate the popup appearing
                    width: popup.visible ? implicitWidth : 0
                    height: popup.visible ? implicitHeight : 0

                    Behavior on width {
                        NumberAnimation {
                            duration: 200
                            easing.type: Easing.OutCubic
                        }
                    }

                    content: Loader {
                        id: innerLoader
                        sourceComponent: popupContent
                        anchors.top: parent.top
                        anchors.left: parent.left
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
        anchor.adjustment: PopupAdjustment.None

        anchor.onAnchoring: {
            const winItem = barWindow.contentItem;

            const center = root.mapToItem(winItem, root.width / 2, root.height / 2);

            anchor.rect.x = root.barWindow.width - 1;

            if (root.smoothBottom) {
                anchor.rect.y = winItem.height - popup.implicitHeight;
            } else {
                const pos = root.mapToItem(winItem, 0, 0);
                anchor.rect.y = pos.y +(root.height - popup.implicitHeight) / 2;
            }
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
