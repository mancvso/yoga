import QtQuick 2.0
import Ubuntu.Components 0.1
import "../Asana.js" as Asana

UbuntuShape {
    width: 200
    height: parent.height


    property string text //: workspaceTrigger.text
    property string wid

    MouseArea {
        anchors.fill: parent
        onClicked: {
            Asana.projects(wid, function(ws){
                for(var w in ws['data']){
                    var o = ws['data'][w];
                    projectModel.append(o)
                }
            });
            console.log(wid);
        }
    }


        /*Button {
            id: workspaceTrigger
            text: "View projects"
            width: parent.width
            height: 100
            enabled: true
            onClicked: {
                console.log(wid);
                Asana.projects(wid, function(ps){
                    for(var p in ps['data']){
                        var o = ps['data'][p];
                        projectModel.append(o)
                    }
                });
            }
        }*/

    ListModel {
        id: projectModel
    }

    ListView {
        model: projectModel
        id: list2
        width: parent.width
        height: 200
        section.property: "name"
        delegate: Component {
            Label {
                text: model.name
            }
        }
    }
}
