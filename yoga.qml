import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import "Storage.js" as Storage
import "Asana.js" as Asana
import "app.js" as UI
/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    ActivityIndicator { id: loader; x: parent.width - width; y:height / 2}
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "com.ubuntu.developer.yoga"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    width: units.gu(100)
    height: units.gu(75)
    ListModel {
        id: listModel
        property string source
        property string jsonString
        onSourceChanged: {
            var objectArray = JSON.parse(jsonString);
            for ( var key in objectArray ) {
                var jo = objectArray[key];
                listModel.append( jo );
            }
        }
    }

    Component.onCompleted: {
        Storage.initialize()
        /*if(Storage.getSetting("dummy") === "settled"){
            Storage.setSetting("dummy", "not-settled")
        } else {
            Storage.setSetting("dummy", "settled")
        }

        console.log(Storage.getSetting("dummy"))*/
        UI.draw_workspaces(workspaces)
    }

    Page {
        title: i18n.tr("Yoga")
        Row {
            spacing: units.gu(1)
            width: parent.width
            height: parent.height

            Column {
                id: workspaces
                width: parent.width / 4
                height: parent.height
                ListItem.Header { text: i18n.tr("Workspaces") }
                ListItem.Divider {}
            }//workspaces

            Column {
                width: parent.width / 4
                height: parent.height
                ListItem.Header {
                    id: projectsHeader
                }
                ListItem.Divider {}

                Column {
                    id: projects
                    width: parent.width
                    height: parent.height
                }

            } //projects

            Column {
                width: parent.width / 4
                height: parent.height
                ListItem.Header {
                    id: tasksHeader
                }
                ListItem.Divider {}

                Column {
                    id: tasks
                    width: parent.width
                    height: parent.height
                }
            } //tasks

            Column {
                width: parent.width / 4
                height: parent.height
                Column {
                    width: parent.width
                    height: units.gu(10)
                    Row {
                        width: parent.width
                        height: units.gu(2)
                        CheckBox {
                            checked: true
                        }
                        Label {
                            id:storiesHeader
                            text: "desc"
                            font.bold: true
                            font.pointSize: 12
                        }
                    }
                    Row{
                        width: parent.width
                        Text {
                            height: units.gu(6)
                            id: storiesDescription
                            color: "#494949"
                            font.pointSize: 10
                            text: "asdasd"
                        }
                    }

                }

                ListItem.ThinDivider {}

                Column {
                    id: stories
                    width: parent.width
                    height: parent.height
                }
            } //stories
        }

    }
    Page {
        title: i18n.tr("Yoga > Project")
    }
}
