import QtQuick
import QtMultimedia
import QtQuick.Dialogs
import QtQuick.Controls
import QtQuick.Layouts

Window {
    id: root
    width: 640
    height: 480
    visible: true
    title: qsTr("Video Player")

    MediaPlayer {
        id: mediaPlayer
        audioOutput: audioOutput
        videoOutput: videoOutput
    }
    AudioOutput {
            id: audioOutput
            volume: volumeSlider.value
        }
    VideoOutput {
        id: videoOutput
        anchors.fill: parent
        width: videoOutput.sourceRect.width
        height: videoOutput.sourceRect.height
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Slider {
            id: volumeSlider
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 20
            orientation: Qt.Horizontal
            value: 0.5
        }

    Item {
        height: 50
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10
            RowLayout {
                                id: controlButtons

                                RoundButton {
                                    id: pauseButton
                                    radius: 50.0
                                    text: "\u2016";
                                    onClicked: mediaPlayer.pause()
                                    }

                                RoundButton {
                                    id: playButton
                                    radius: 50.0
                                    text: "\u25B6";
                                    onClicked: mediaPlayer.play()
                                    }

                                RoundButton {
                                    id: stopButton
                                    radius: 50.0
                                    text: "\u25A0";
                                    onClicked: mediaPlayer.stop()
                                   }

                                    anchors.fill: parent
                                        Text {
                                            id: mediaTime
                                            Layout.minimumWidth: 50
                                            Layout.minimumHeight: 18
                                            horizontalAlignment: Text.AlignRight
                                            text: {
                                                var m = Math.floor(mediaPlayer.position / 60000)
                                                var ms = (mediaPlayer.position / 1000 - m * 60).toFixed(1)
                                                return `${m}:${ms.padStart(4, 0)}`
                                            }
                                        }
                                        Slider {
                                            id: mediaSlider
                                            Layout.fillWidth: true
                                            enabled: mediaPlayer.seekable
                                            to: 1.0
                                            value: mediaPlayer.position / mediaPlayer.duration

                                            onMoved: mediaPlayer.setPosition(value * mediaPlayer.duration)
                                        }
                       }



           }

    FileDialog {
        id: fileDialog

        nameFilters: ["Video Files (*.avi *.mp4 *.mkv)"]

        onAccepted: {
            mediaPlayer.stop()
            mediaPlayer.source = fileDialog.selectedFile
            mediaPlayer.play()
        }
    }

    Button {

            text: qsTr("Select video")
            onClicked: fileDialog.open()
        }

}
