import QtQuick 2.5
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.XmlListModel 2.0

ApplicationWindow {
    id:mainWindow
    visible: true
    width: 640
    height: 480
    minimumHeight:480
    minimumWidth: mainToolBar.implicitWidth
    title: qsTr("Flick - Desktop")

    toolBar: ToolBar{
        id:mainToolBar
        height:40
        RowLayout{
            width: parent.width
            Button{
                text:"Download";
            }
            Button{
                text:"Refresh";          
            }
            Slider{
                Layout.fillWidth: true
            }
            TextField{
                 id:searchFiled
            }
        }
    }

    SplitView{
        anchors.fill:parent
        TableView{
            id:flickTable
            frameVisible: false
            TableViewColumn{
                title:"Images"
                role:"name"
            }
            model:flickModel
        }
        Image{
            id:image
            fillMode: Image.PreserveAspectFit
            source:(flickModel.get(flickTable.currentRow)) ? (flickModel.get(flickTable.currentRow).source) :"http://localhost:8082/api/flick/photos/default.jpg"
        }

    }
    statusBar: StatusBar{
        RowLayout{
            width:parent.width
            Label{
                id:label
                text:image.source
                Layout.fillWidth: true
                elide: Text.ElideMiddle
            }
            ProgressBar{
                value:image.progress
            }
        }


    }

    XmlListModel{
        id:flickModel;
        source:"http://localhost:8082/api/flick/?cmd=get"
        query:"/data/images/image";

        XmlRole{ name:"name"; query:"name/string()"}
        XmlRole{ name:"source"; query:"url/string()"}
        XmlRole{ name:"date"; query:"uploadedDate/string()"}
        XmlRole{ name:"format"; query:"format/string()"}
        XmlRole{ name:"category"; query:"category/string()"}
    }


}
