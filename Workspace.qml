import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import "app.js" as UI
import "Asana.js" as Asana

ListItem.Standard {
    property string workspaceID
    selected: false
    onClicked: {
        selected = !selected
        console.log("--> " + workspaceID)
        projectsHeader.text = text
        projects.children = [];
        //tasks.children = [];
        //stories.children = [];
        loader.running = true;
        Asana.projects(workspaceID, function(ws){
            for(var w in ws['data']){
                var o = ws['data'][w];
                var wss = Qt.createComponent("Project.qml");
                wss.createObject(projects, {"text": o.name, "projectID": o.id});
            }
            loader.running = false;
        });
    }
    progression: true
}
