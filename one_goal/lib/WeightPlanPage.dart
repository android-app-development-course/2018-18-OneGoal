import 'package:flutter/material.dart';

class Reading extends StatefulWidget
{
  Reading({Key key}): super(key: key);

  @override
  ReadingState createState() => new ReadingState();
}



class ReadingState extends State<Reading> {


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
        title: new Text("读书计划"),
      ),
      body: new Container(
          margin: const EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 10.0),
          child: new Column(
            children: <Widget>[
              //完成度
              _getNameText(context, '完成度（$mission/$maxmission）'),
              new LinearProgressIndicator(value: mission/maxmission),





            ],
          )
      ),
    );
  }


}
