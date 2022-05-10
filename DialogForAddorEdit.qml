import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 2.5   // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 1.2


Window {
    id: root
    modality: Qt.ApplicationModal  // окно объявляется модальным
    title: qsTr("Добавление информации о собаке")
    minimumWidth: 400
    maximumWidth: 400
    minimumHeight: 200
    maximumHeight: 200

    property bool isEdit: false
    property int currentIndex: -1

    GridLayout {
        anchors { left: parent.left; top: parent.top; right: parent.right; bottom: buttonCancel.top; margins: 10 }
        columns: 2

        Label {
                Layout.alignment: Qt.AlignRight  // выравнивание по правой стороне
                text: qsTr("Имя собаки:")
            }
            TextField {
                id: textName
                Layout.fillWidth: true
                placeholderText: qsTr("Введите имя")
            }
            Label {
                Layout.alignment: Qt.AlignRight
                text: qsTr("Возраст:")
            }
            TextField {
                id: textAge
                Layout.fillWidth: true
                placeholderText: qsTr("Введите возраст")
            }
            Label {
                Layout.alignment: Qt.AlignRight
                text: qsTr("Порода:")
            }
            TextField {
                id: textBreed
                Layout.fillWidth: true
                placeholderText: qsTr("Введите породу")
            }
            Label {
                Layout.alignment: Qt.AlignRight
                text: qsTr("Владелец:")
            }
            TextField {
                id: textOwner
                Layout.fillWidth: true
                placeholderText: qsTr("Введите владельца")
            }

    }

    Button {
        anchors { right: buttonCancel.left; verticalCenter: buttonCancel.verticalCenter; rightMargin: 10 }
        text: qsTr("ОК")
        width: 100
        onClicked: {
            root.hide()
            if (currentIndex<0)
            {
                add(textName.text, textAge.text, textBreed.text, textOwner.text)
            }
            else
            {
                edit(textName.text, textAge.text, textBreed.text, textOwner.text, root.currentIndex)
            }

        }
    }

    Button {
        id: buttonCancel
        anchors { right: parent.right; bottom: parent.bottom; rightMargin: 10; bottomMargin: 10 }
        text: qsTr("Отменить")
        width: 100
        onClicked: {
             root.hide()
        }
    }

    // изменение статуса видимости окна диалога
    onVisibleChanged: {
      if (visible && currentIndex < 0) {
          textName.text = ""
          textAge.text = ""
          textBreed.text = ""
          textOwner.text = ""
      }
    }

    function execute(name, age, breed, owner, index){
            textName.text = name
            textAge.text = age
            textBreed.text = breed
            textOwner.text = owner
            root.currentIndex = index

            root.show()
        }
 }
