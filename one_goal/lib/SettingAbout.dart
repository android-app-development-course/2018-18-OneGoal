import 'package:flutter/material.dart';

class SettingAbout extends StatelessWidget
{
  static String version = 'V0.5';

  SettingAbout(): super();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: new Text("关于"),
        backgroundColor: Colors.grey,
      ),
      body: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Expanded(
                  child: new Container(
                    padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
                    alignment: Alignment.center,
                    child: new Image.asset("image/icon.png",),
                  ),
              ),
            ],
          ),

          new Row(
            children: <Widget>[
              new Expanded(
                child: new Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  alignment: Alignment.center,
                  child: new Text(version, style: TextStyle(fontSize: 16, color: Colors.grey),),
                ),
              ),
            ],
          ),

          new Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: new Text("OneGoal属于生活服务类应用程序，是发现自我，实现自我的成长记录型工具。\n\n"+
                    "用户可以指定一个希望实现的目标，并填写相关信息，指定后不可更改。"
                    "此后，这款应用将与该目标\"绑定\"，用户可以记录与最初设定目标所有相关的事宜，"
                    "包括完成情况、情绪或感悟心得等。 一旦用户完成或放弃了目标，就宣告了该软件生命的结束。"
                    "届时，将会生成一份报告，记录了用户曾经为目标所付出的所有努力。"),
          ),

        ],
      ),
      resizeToAvoidBottomPadding: false,
    );
  }
}