import QtQuick 2.6
import QtQuick.Controls 2.5  // это версия библиотеки, содержащей Contol (аналоги виджетов) для версии Qt 5.6
import QtQuick.Layouts 1.2

Rectangle {
    id: dogItem
    readonly property color evenBackgroundColor: "#FFA07A"  // цвет для четных пунктов списка
    readonly property color oddBackgroundColor: "#CD5C5C"   // цвет для нечетных пунктов списка
    readonly property color selectedBackgroundColor: "#FF0000"  // цвет выделенного элемента списка

    property bool isCurrent: dogItem.ListView.view.currentIndex === index   // назначено свойство isCurrent истинно для текущего (выделенного) элемента списка
    property bool selected: dogItemMouseArea.containsMouse || isCurrent // назначено свойство "быть выделенным",
    //которому присвоено значение "при наведении мыши,
    //или совпадении текущего индекса модели"

    property variant dogData: model // свойство для доступа к данным конкретного студента

    width: parent ? parent.width : dogList.width
    height: 160

    // состояние текущего элемента (Rectangle)
    states: [
        State {
            when: selected
            // как реагировать, если состояние стало selected
            PropertyChanges { target: dogItem;  // для какого элемента должно назначаться свойство при этом состоянии (selected)
                color: isCurrent ? palette.highlight : selectedBackgroundColor  /* какое свойство целевого объекта (Rectangle)
                                                                                                  и какое значение присвоить*/
            }
        },
        State {
            when: !selected
            PropertyChanges { target: dogItem;  color: isCurrent ? palette.highlight : index % 2 == 0 ? evenBackgroundColor : oddBackgroundColor }
        }
    ]

    MouseArea {
        id: dogItemMouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            dogItem.ListView.view.currentIndex = index
            dogItem.forceActiveFocus()
        }
    }
    Item {
            id: itemOfDogs
            width: parent.width
            height: 160
            Column{
                id: t2
                anchors.left: parent.left
                anchors.leftMargin: 10
                width: 240
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    id: t0
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "ID:"
                    color: "DarkBlue"
                    font.pointSize: 12
                }
                Text {
                    id: textid
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: Id_dog
                    color: "DarkBlue"
                    font.pointSize: 18
                    font.bold: true
                }
                Text {
                    id: t1
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Имя собаки:"
                    color: "DarkBlue"
                    font.pointSize: 12
                }
                Text {
                    id: textName
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: Name
                    color: "DarkBlue"
                    font.pointSize: 18
                    font.bold: true
                }
            }
            Column{
                anchors.left: t2.right
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    text: "Возраст:"
                    color: "DarkBlue"
                    font.pointSize: 10
                }
                Text {
                    id: textAge
                    text: Age
                    color: "DarkBlue"
                    font.pointSize: 12
                    font.bold: true
                }
                Text {
                    text: "Порода:"
                    color: "DarkBlue"
                    font.pointSize: 10
                }
                Text {
                    id: textBreed
                    color: "DarkBlue"
                    text: Breed
                    font.pointSize: 12
                    font.bold: true
                }
                Text {
                    text: "Владелец:"
                    color: "DarkBlue"
                    font.pointSize: 10
                }
                Text {
                    id: textOwner
                    text: Owner
                    color: "DarkBlue"
                    font.pointSize: 12
                    font.bold: true
                }

            }

        }
}
