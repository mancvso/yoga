import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import Ubuntu.Components 0.1
import "components"
import "Storage.js" as Storage
import "Asana.js" as Asana
import "app.js" as UI
/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
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
        UI.draw_workspaces(listModel)
    }

    Page {
        title: i18n.tr("Yoga")

        Column {
            spacing: units.gu(10)
            anchors {
                margins: units.gu(3)
            }

            ListView {
                model: listModel
                id: list1
                width: parent.width / listModel.count
                height: parent.height
                section.property: "name"
                delegate: Component {
                    Workspace {
                        text: model.name
                        wid: model.id
                        width: 100
                        height: 250
                        smooth: true
                    }
                }
            }

        }

    }
}
