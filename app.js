function draw_workspaces(root){
    loader.running = true;
    Asana.workspaces(function(ws){
        for(var w in ws['data']){
            var o = ws['data'][w];
            var component = Qt.createComponent("Workspace.qml");
            component.createObject(root, {"text": o.name, "workspaceID": o.id});
        }
        //finished loading workspaces
        loader.running = false;
    });
}

function reloadProjects(root, workspaceID, workspaceName){
    console.log("--> " + workspaceID)
    root.caption = workspaceName
    loader.running = true;
    Asana.projects(workspaceID, function(ps){
        for(var w in ws['data']){
            var o = ws['data'][w];
            var wss = Qt.createComponent("Project.qml");
            wss.createObject(root, {"text": o.name, "projectID": o.id});
        }
        loader.running = false;
    });
}
