import 'package:flutter/material.dart';

class SettingFeedback extends StatefulWidget
{
  SettingFeedback({Key key}): super(key: key);

  @override
  SettingFeedbackState createState() => new SettingFeedbackState();
}

class SettingFeedbackState extends State<SettingFeedback>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: new Text("意见反馈"),
      ),
    );
  }
}