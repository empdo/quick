import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Services.Pipewire
import "modules" as Modules
import "."

Item {
    id: root
    implicitWidth: 220
    implicitHeight: 110

    property var popup
    property color textColor: "#ebffd9"

    RowLayout{
        anchors.fill: parent
        anchors.margins: 30
        anchors.leftMargin: 30
        spacing: 38

        Label {
            text: "󰍃"
            color: textColor
            font.pixelSize: 24
            font.bold: true
            Layout.alignment: Qt.AlignBottom
        }

        Label {
            text: "󰒲"
            color: textColor
            font.pixelSize: 24
            font.bold: true
            Layout.alignment: Qt.AlignBottom
        }

        Label {
            text: ""
            color: textColor
            font.pixelSize: 24
            font.bold: true
            Layout.alignment: Qt.AlignBottom
        }

    }

    MouseArea {
        hoverEnabled: true

        onExited: {
            root.popup.hidePopup();
        }
    }
}

