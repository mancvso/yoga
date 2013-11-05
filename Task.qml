import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import "Asana.js" as Asana

ListItem.Standard {
    property string taskID
    property string caption
    property alias completed:chk.checked
    property string description
    selected: false
    text:caption
    progression: true
    control {
        CheckBox {
            id:chk
            onCheckedChanged: chk.enabled = false
        }

    }

    onClicked: {
        selected = !selected
        storiesHeader.text = caption
        storiesDescription.text = description
        console.log(description)
        stories.children = [];
        loader.running = true;
        Asana.stories(taskID, function(ws){
            for(var w in ws['data']){
                var o = ws['data'][w];
                var wss = (o.type === "comment") ? Qt.createComponent("Comment.qml") : Qt.createComponent("Notification.qml");

                if (wss.status === Component.Ready){
                    wss.createObject(stories, {"caption": o.text, "storyID": o.id, "createdBy":o.created_by['name']});
                } else {
                    console.log("not ready!");
                }
            }
            loader.running = false;
        });
    }
}
