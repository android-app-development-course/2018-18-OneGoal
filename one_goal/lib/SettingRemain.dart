import 'package:flutter/material.dart';
import 'package:one_goal/Model.dart';

class SettingRemain extends StatefulWidget
{
  SettingRemain({Key key}): super(key: key);

  @override
  SettingRemainState createState() => new SettingRemainState();
}

class SettingRemainState extends State<SettingRemain>
{
  //提醒频率的值
  static const FREQUENCY_NONE = 'none';
  static const FREQUENCY_ONE_DAY = 'one day';
  static const FREQUENCY_THREE_DAY = 'three day';
  static const FREQUENCY_ONE_WEEK = 'one week';

  String _remainFrequency = FREQUENCY_NONE;

  @override
  Widget build(BuildContext context)
  {
    // TODO: implement build
    _remainFrequency = initFrequency();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("提醒频率"),
        backgroundColor: Colors.grey,
      ),
      body: new Column(
        children: <Widget>[
          new RadioListTile(
            title: new Text("不提醒"),
            value: FREQUENCY_NONE,
            groupValue: _remainFrequency,
            onChanged: (String value) => setFrequency(value),
          ),
          new RadioListTile(
              title: new Text("一天"),
              value: FREQUENCY_ONE_DAY,
              groupValue: _remainFrequency,
              onChanged: (String value) => setFrequency(value),
          ),
          new RadioListTile(
            title: new Text("三天"),
            value: FREQUENCY_THREE_DAY,
            groupValue: _remainFrequency,
            onChanged: (String value) => setFrequency(value),
          ),
          new RadioListTile(
            title: new Text("一周"),
            value: FREQUENCY_ONE_WEEK,
            groupValue: _remainFrequency,
            onChanged: (String value) => setFrequency(value),
          ),
        ],
      ),
    );
  }

  //初始化提醒频率
  String initFrequency()
  {
    String temp=Model().getFrequency();
    return temp == null ? FREQUENCY_NONE : temp;
  }

  //设置提醒频率
  void setFrequency(String value)
  {
    setState(() {_remainFrequency=value;});
    Model().setFrequency(value);
  }

  //返回提醒频率
  String getRemainFrequency()
  {
    return _remainFrequency;
  }
}











