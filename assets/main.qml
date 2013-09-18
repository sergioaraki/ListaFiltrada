import bb.cascades 1.0
import bb.data 1.0

Page {
    Container {
        layout: StackLayout {
        }
        TextField {
            id: filtro
            hintText: "Buscar" 
            enabled: false
            onTextChanging: {
                if (text != ''){
                    groupDataModel2.clear();
                    for (var i=0; i<groupDataModel.size(); i++){
                        var index = groupDataModel.data([i]).title.indexOf(text);
                        if (index != -1){
                            var item = groupDataModel.data([i]);
                            item.title = "<html>"+item.title.replace(text,"<font style=\"color: #3274D1\">"+item.title.substr(index,text.length)+"</font>")+"</html>";
                            groupDataModel2.insert(item);
                        }
                    }
                    lista.dataModel = groupDataModel2;
                }
                else {
                    lista.dataModel = groupDataModel;
                }
            }
        }
        ListView {
            id: lista
            dataModel: groupDataModel
            listItemComponents: [
                ListItemComponent {
                    type: "item"
                    StandardListItem {
                        title: ListItemData.title
                    }
                }
            ]
        }
    }
    attachedObjects: [
        GroupDataModel {
            id: groupDataModel
            grouping: ItemGrouping.None
        },
        DataSource {
            id: dataSource
            source: "http://feeds.feedburner.com/blackberry/CAxx?format=xml"
            query: "rss/channel/item"
            onDataLoaded: {
                groupDataModel.insertList(data);
                filtro.enabled = true;
            }
        },
        GroupDataModel {
            id: groupDataModel2
            grouping: ItemGrouping.None
        }
    ]
    onCreationCompleted: {
        dataSource.load();
    }
}
