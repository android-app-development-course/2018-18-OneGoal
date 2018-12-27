import 'package:flutter/material.dart';
import 'package:one_goal/Model.dart';

class SettingFeedback extends StatefulWidget
{
  SettingFeedback({Key key}): super(key: key);

  @override
  SettingFeedbackState createState() => new SettingFeedbackState();
}

class SettingFeedbackState extends State<SettingFeedback>
{
  TextEditingController _textEditingController = TextEditingController();
  String _suggestion;

  @override
  Widget build(BuildContext context)
  {
    _suggestion = "";
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: new Text("意见反馈"),
      ),
      body: new Padding(
          padding: EdgeInsets.all(20),
          child: new Column(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
                child: new Row(
                  children: <Widget>[
                    new Text("反馈意见:", textAlign: TextAlign.left, style: new TextStyle(fontSize: 18),),
                  ],
                ),
              ),

              new TextField(
                decoration: new InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                ),
                controller: _textEditingController,
                maxLines: 8,
                style: new TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),

              ),
              new Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new RaisedButton(
                        child: new Text("提交", style: TextStyle(color: Colors.white, fontSize: 18),),
                        color: Colors.blue,
                        onPressed: () {
                          setState((){
                            _suggestion = _textEditingController.text;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
      resizeToAvoidBottomPadding: false,
    );
  }

}