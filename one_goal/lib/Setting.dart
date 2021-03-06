import 'package:flutter/material.dart';
import 'package:one_goal/SettingRemain.dart';
import 'package:one_goal/SettingFeedback.dart';
import 'package:one_goal/SettingAbout.dart';
import 'package:one_goal/Model.dart';
import 'package:one_goal/ResultOfReading.dart';

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
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (context) => new SettingRemain())
                    );
                  },
                  title: new Text("提醒频率", style: new TextStyle(fontWeight: FontWeight.w500)),
                  leading: new Icon(
                    Icons.access_alarms,
                    color: Colors.blueGrey,
                  ),
                  trailing:new Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blueGrey,
                  )
              ),

              new Divider(),

              new ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                        new MaterialPageRoute(builder: (context) => new SettingFeedback())
                    );
                  },
                  title: new Text("意见反馈", style: new TextStyle(fontWeight: FontWeight.w500,),),

                  leading: new Icon(
                    Icons.chat,
                    color: Colors.blueGrey,
                  ),
                  trailing:new Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blueGrey,
                  )
              ),

              new Divider(),

              new ListTile(
                  onTap: () {
                    Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => new SettingAbout())
                    );
                  },
                  title: new Text("关于", style: new TextStyle(fontWeight: FontWeight.w500)),
                  leading: new Icon(
                    Icons.info_outline,
                    color: Colors.blueGrey,
                  ),
                  trailing:new Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.blueGrey,
                  )
              ),

              new Divider(),

              new Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: new Column(
                  children: <Widget>[
                    new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new RaisedButton(
                              onPressed: () {
                                _clearData();
                              },
                              textColor: Colors.white,
                              color: Colors.green,
                              child: new Text("新建计划", style: new TextStyle(fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ]
                    ),
                    new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new RaisedButton(
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                  new MaterialPageRoute(builder: (context) => new ResultOfReading()),
                                  (Route route) => route == null);
                              },
                              textColor: Colors.white,
                              color: Colors.red,
                              child: new Text("结束计划", style: new TextStyle(fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ]
                    ),
                  ],
                ),
              ),

            ],
          )
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

  Future<void> _clearData() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('警告'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('新建计划将清除所有旧数据\n是否继续？'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('是'),
              onPressed: () {
                //Model().clearData();
                Navigator.pushNamedAndRemoveUntil(context,
                  '/goalnamepage', (Route route) => route == null);
              },
            ),
            FlatButton(
              child: Text('否'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}

