import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import "Asana.js" as Asana

ListItem.Standard {
    property string projectID
    selected: false
    onClicked: {
        selected = !selected
        console.log("--> " + workspaceID)
        tasksHeader.text = text
        tasks.children = [];
        //stories.children = [];
        loader.running = true;
        Asana.tasks(projectID, function(ws){
            for(var w in ws['data']){
                var o = ws['data'][w];
                console.log(o.notes);
                var wss = Qt.createComponent("Task.qml");
                if (wss.status === Component.Ready){
                    wss.createObject(tasks,
                        {
                            "caption": o.name,
                            "taskID": o.id,
                            "completed":o.completed,
                            "description":o.notes
                        });
                }
            }
            loader.running = false;
        });
    }
    progression: true
}
