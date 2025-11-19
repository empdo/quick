import Quickshell
import QtQuick
import QtQuick.Controls
import Qt.labs.folderlistmodel 2.1
import Quickshell.Io
import "../wallpaper/" as Modules

Rectangle {
    id: root
    width: 300
    height: 800
    color: "transparent"

    FolderListModel {
        id: imageModel
        folder: "file:///home/emil/Pictures/"
        nameFilters: ["*.png", "*.PNG", "*.jpg", "*.JPG", "*.jpeg", "*.JPEG", "*.gif"]
    }

    ListView {
        id: listView

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            rightMargin: 1
            topMargin: 20
            bottomMargin: 20

            // let the contentArea enforce padding
            // do NOT fill parent directly
        }

        clip: true
        spacing: 10
        orientation: ListView.Vertical
        model: imageModel

        delegate: Item {
            width: listView.width
            height: img.height + 10
            Process {
                id: setWallpaper
                command: ["/home/emil/.config/hypr/setwallpaper.sh", filePath]
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    setWallpaper.running = true
                }
            }

            Image {
                id: img
                anchors.horizontalCenter: parent.horizontalCenter
                source: "file:///" + filePath
                width: listView.width - 20
                fillMode: Image.PreserveAspectFit
                asynchronous: true
            }
        }
    }

    // TOP FADE
    Rectangle {
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            rightMargin: 1
            topMargin: 20
            bottomMargin: 20
        }
        height: 80   // how big the fade is
        z: 100
        gradient: Gradient {
            GradientStop {
                position: 1.0
                color: "#00000000"
            }  // transparent
            GradientStop {
                position: 4.0
                color: "#1a1a1a"
            }  // black @ 80% opacity
            GradientStop {
                position: 0.0
                color: "#1a1a1a"
            }  // black @ 80% opacity
        }
    }

    // BOTTOM FADE
    Rectangle {
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
            rightMargin: 1
            topMargin: 20
            bottomMargin: 20
        }
        height: 80
        z: 100
        gradient: Gradient {
            GradientStop {
                position: 1.0
                color: "#1a1a1a"
            }  // black @ 80%
            GradientStop {
                position: 6.0
                color: "#1a1a1a"
            }  // black @ 80% opacity
            GradientStop {
                position: 0.0
                color: "#00000000"
            }  // transparent
        }
    }
}
