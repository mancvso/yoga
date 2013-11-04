function draw_workspaces(listModel){
    Asana.workspaces(function(ws){
        for(var w in ws['data']){
            var o = ws['data'][w];
            listModel.append(o)
        }
    });
}
