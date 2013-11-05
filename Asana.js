/*
    A suite of functions to pull down the right bits of data
    from asana.
*/

var _api_base = 'https://app.asana.com/api/%1/%2';
var _api_version = '1.0';
var asana_url = _api_base.arg(_api_version); //%1
var _api_key = "kauDlxj.okZhTJiVJ3IAshyXoKhSKVB7";
var _expected_content_type = "application/json; charset=UTF-8";

function _asana_get(module, callback, debug){
    var url = (debug === true) ? asana_url.arg(module) + "?opt_pretty": asana_url.arg(module); //%2
    var timeout = 30000;

    var doc = new XMLHttpRequest();
    //lambda
    doc.onreadystatechange = function() {
        if (doc.readyState === XMLHttpRequest.DONE){
            if(doc.status == 200 && doc.getResponseHeader("content-type") === _expected_content_type){
                callback( JSON.parse(doc.responseText) );
                if(debug === true){
                    console.log(doc.responseText);
                }
            } else {
                console.error("STATUS:" + doc.status + " \nHEADERS: " + doc.getAllResponseHeaders() + "\n BODY: " + doc.responseText);
            }
        }
    }

    doc.open("get", url);
    doc.setRequestHeader("Authorization", "Basic " + _basic_auth(_api_key));
    doc.setRequestHeader("Content-Encoding", "UTF-8");
    doc.send();
}

//token:token_base_64
function _basic_auth(token){
    var token_base = token + ':';
    return "a2F1RGx4ai5va1poVEppVkozSUFzaHlYb0toU0tWQjc6"; //token_base.toBase64();
}

function get_workspaces(){
    return _asana_get("workspaces", function(data){
        //workspaces = data;
        console.log(data);
        return data;
    });
}

function workspaces(callback){
    _asana_get("workspaces", callback);
}

function get_projects(workspace_id){

    _asana_get("workspaces/"+workspace_id+"/projects", function(data){
        console.log(data);
    });
}

function projects(workspace_id, callback) {
    _asana_get("workspaces/"+workspace_id+"/projects", callback);
}

function get_tasks(project_id) {

    _asana_get("projects/"+project_id+"/tasks", function(data){
        console.log(data);
    });
}

function tasks(project_id, callback) {
    _asana_get("projects/"+project_id+"/tasks?opt_fields=assignee,completed,name,notes&opt_pretty", callback); //XXX debug
}

function get_stories(task_id) {

    _asana_get("tasks/"+task_id+"/stories", function(data){
        console.log(data);
    });
}

function stories(task_id, callback) {
    _asana_get("tasks/"+task_id+"/stories", callback);
}


