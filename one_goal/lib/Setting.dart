import 'package:flutter/material.dart';

class Setting extends StatefulWidget
{
  Setting({Key key}): super(key: key);

  @override
  SettingState createState() => new SettingState();
}



class SettingState extends State<Setting> {


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.grey,
        title: new Text("设置"),
      ),
      body: new Container(
          margin: const EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 10.0),
          child: new Column(
            children: <Widget>[


              //new Divider(),

              new ListTile(
                  onTap: () {
                    print('点击');
                  },
                  title: new Text("提醒功能 ", style: new TextStyle(fontWeight: FontWeight.w500)),
                  leading: new Icon(
                    Icons.access_alarms,
                    color: Colors.blue[500],
                  ),
                  trailing:new Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue[500],
                  )
              ),

              new Divider(),

              new ListTile(
                  onTap: () {
                    print('点击');
                  },
                  title: new Text("意见反馈", style: new TextStyle(fontWeight: FontWeight.w500,),),

                  leading: new Icon(
                    Icons.chat,
                    color: Colors.blue[500],
                  ),
                  trailing:new Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue[500],
                  )
              ),

              new Divider(),

              new ListTile(
                  onTap: () {
                    print('点击');
                  },
                  title: new Text("通用", style: new TextStyle(fontWeight: FontWeight.w500)),
                  leading: new Icon(
                    Icons.apps,
                    color: Colors.blue[500],
                  ),
                  trailing:new Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blue[500],
                  )
              ),

              new Divider(),

              /*new ListTile(
                  onTap: () {
                    print('点击');
                  },

                  title: new Text("结束任务", style: new TextStyle(fontWeight: FontWeight.w500,color: Colors.red),),
                  leading: new Icon(
                    Icons.access_alarms,
                    color: Colors.blue[500],
                  )
              ),

              new Divider(),*/

              new Row(
                children: <Widget>[
                  new Expanded(
                      child: new RaisedButton(
                        onPressed: () => {},
                        textColor: Colors.white,
                        color: Colors.red,
                        child: new Text("结束任务", style: new TextStyle(fontWeight: FontWeight.w500)),
                      ),
                  ),
                ]
              ),




            ],
          )
      ),
    );



  }

}

