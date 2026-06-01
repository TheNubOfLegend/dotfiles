import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import Quickshell.Services.UPower 

ShellRoot {
    Scope {
        id: config
        property bool isVisible: false
        property string currentTime: ""
        property string currentDate: ""
    }

    // This function only runs when you actually trigger the HUD
    function refreshData() {
        let now = new Date();
        config.currentTime = now.toLocaleTimeString(Qt.locale(), "hh:mm ap");
        config.currentDate = now.toLocaleDateString(Qt.locale(), "dddd, MMMM d");
    }

    IpcHandler {
        target: "hud"
        function toggle(): void {
            // Only update the strings when we are about to show the HUD
            if (!config.isVisible) {
                refreshData();
            }
            config.isVisible = !config.isVisible;
        }
    }

    Variants {
        model: [ "hud" ]
        delegate: WlrLayershell {
            id: hudWindow
            anchors { top: true; bottom: true; left: true; right: true }
            layer: WlrLayershell.Overlay
            namespace: "quickshell-hud"
            visible: config.isVisible 
            color: "transparent" 

            Rectangle {
                anchors.centerIn: parent
                width: 420; height: 260; radius: 20
                color: "#282828"; border.color: "#a9b665"; border.width: 2

                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 8

                    // Clock
                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: config.currentTime
                        font.pixelSize: 56
                        font.family: "JetBrainsMono Nerd Font"
                        color: "#d4be98"
                    }

                    // Date
                    Text {
                        Layout.alignment: Qt.AlignHCenter
                        text: config.currentDate
                        font.pixelSize: 18
                        font.family: "JetBrainsMono Nerd Font"
                        color: "#7daea3"
                    }

                    Rectangle {
                        Layout.alignment: Qt.AlignHCenter
                        width: 120; height: 1; color: "#504945"
                    }

                    // Battery (UPower handles its own updates efficiently)
                    Repeater {
                        model: UPower.devices
                        delegate: RowLayout {
                            visible: modelData.isLaptopBattery 
                            Layout.alignment: Qt.AlignHCenter
                            spacing: 10
                            
                            Text {
                                text: modelData.percentage < 0.2 ? "󰂃" : "󰁹"
                                font.pixelSize: 24
                                font.family: "JetBrainsMono Nerd Font"
                                color: "#d8a657"
                            }

                            Text {
                                text: Math.round(modelData.percentage * 100) + "%"
                                font.pixelSize: 24
                                font.family: "JetBrainsMono Nerd Font"
                                color: "#d8a657"
                            }
                        }
                    }
                }
            }
        }
    }
}
