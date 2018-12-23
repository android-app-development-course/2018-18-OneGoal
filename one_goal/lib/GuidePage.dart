import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuidePage extends StatefulWidget
{
  GuidePage({Key key}): super(key: key);

  @override
  GuidePageState createState() => new GuidePageState();
}

class GuidePageState extends State<GuidePage>
{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Guide"),
      ),
      body: new Center(
        child: new Text("This is guide page"),
      ),
      floatingActionButton: new FloatingActionButton(onPressed: _finish, child: new Icon(Icons.add)),
    );
  }

  void _finish() async
  {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool("isGuidePage", true);
  }
}