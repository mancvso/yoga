import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import "Asana.js" as Asana

ListItem.Subtitled {
    property string storyID
    property string createdBy
    property string caption
    text : caption
    subText: createdBy
}
