import 'package:flutter/material.dart';

class Reading extends StatefulWidget
{
  Reading({Key key}): super(key: key);

  @override
  ReadingState createState() => new ReadingState();
}



class ReadingState extends State<Reading> {


  String kg="5";
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
        title: new Text("体重计划"),
      ),
      body: new Container(
          margin: const EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 10.0),
          child: new Column(
            children: <Widget>[
              //完成度
              _getNameText(context, '完成度（$mission/$maxmission）'),
              new LinearProgressIndicator(value: mission/maxmission),

              new Text( "目标体重为"+kg+"kg",
                style: new TextStyle(
                  fontSize:25.0,
                  color: Colors.black,
                  height: 1.5,)),

              new TextField(
                decoration: InputDecoration(
                   border: OutlineInputBorder(),
                   labelText: '今日体重',
                   prefixIcon: Icon(Icons.person),
                   ),
              )



            ],
          )
      ),
    );
  }


}
