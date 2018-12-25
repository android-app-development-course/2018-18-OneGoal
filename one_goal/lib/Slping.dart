import 'package:flutter/material.dart';

class Sleeping extends StatefulWidget
{
  Sleeping({Key key}): super(key: key);

  @override
  SleepingState createState() => new SleepingState();
}



class SleepingState extends State<Sleeping> {

    int mission=0;
    int maxmission=100;

    Align _getNameText(BuildContext context, String text) {
      return new Align(
          alignment: FractionalOffset.topCenter,
          child: new Text(
              text,
              style: new TextStyle(
                fontSize: 15.0,
                color: Colors.black,
                height: 1.5,
              )
          )
      );
    }

    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("早睡计划"),
        ),
        body: new Container(
            margin: const EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 10.0),
            child: new Column(
                children: <Widget>[
                  new LinearProgressIndicator(value: mission/maxmission),
                  _getNameText(context, '完成度（$mission/$maxmission）'),
                ]
            )
        ),
      );
    }
}