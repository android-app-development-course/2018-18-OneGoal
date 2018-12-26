import 'package:flutter/material.dart';

class Sleeping extends StatefulWidget
{
  Sleeping({Key key}): super(key: key);

  @override
  SleepingState createState() => new SleepingState();
}



class SleepingState extends State<Sleeping> {

    DateTime clickDate=new DateTime.now();
    TimeOfDay clickTime=new TimeOfDay.now();
    int mission=0;
    int maxmission=100;
    String title="广东";
    String content="家里，睡觉";

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


    void titleChange(String str){
      setState(() {
        title =str;
      });
    }

    void titleChange2(String str){
      setState(() {
        content =str;
      });
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
                  //完成度
                  _getNameText(context, '完成度（$mission/$maxmission）'),
                  new LinearProgressIndicator(value: mission/maxmission),


                  new ListTile(
                      onTap: () {
                        showDialog<Null>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return new AlertDialog(
                              title:   new TextField(
                                decoration: InputDecoration(
                                  labelText: '标题',
                                ),
                                onChanged:titleChange,
                            ),
                              content: new SingleChildScrollView(
                                child: new ListBody(
                                  children: <Widget>[
                                    new TextField(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        prefixIcon: Icon(Icons.person),
                                      ),
                                      onChanged:titleChange2,
                                    ),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text('确定'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        ).then((val) {
                          print(val);
                        });
                      },
                      title: new Text(title, style: new TextStyle(fontWeight: FontWeight.w500)),
                      subtitle: new Text(content),
                      leading: new Icon(
                        Icons.business,
                        color: Colors.blue[500],
                      )
                  ),


                  new Divider(),

                  new ListTile(
                      onTap: () {
                        print('点击');
                      },
                      title: new Text(clickTime.toString().substring(10,15), style: new TextStyle(fontWeight: FontWeight.w500)),
                      leading: new Icon(
                        Icons.access_alarms,
                        color: Colors.blue[500],
                      )
                  ),

                  new Divider(),

                  new ListTile(
                      onTap: () {
                        print('点击');
                      },
                      title: new Text(clickDate.toString().substring(0,10), style: new TextStyle(fontWeight: FontWeight.w500)),
                      leading: new Icon(
                        Icons.airline_seat_individual_suite,
                        color: Colors.blue[500],
                      )
                  ),

                  new Divider(),


                  new Padding(
                    padding: const EdgeInsets.all(50.0),

                  ),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        new RaisedButton(
                          onPressed:showDate,
                          color: Colors.lightBlueAccent,//按钮的背景颜色
                          padding: EdgeInsets.all(10.100),//按钮距离里面内容的内边距
                          child: new Text('确定'),
                          textColor: Colors.black,//文字的颜色
                          textTheme:ButtonTextTheme.normal ,//按钮的主题
                          onHighlightChanged: (bool b){//水波纹高亮变化回调
                          },
                          splashColor: Colors.white,//水波纹的颜色
                          elevation: 5.0,//按钮下面的阴影
                        ),
                        new RaisedButton(
                          onPressed:showDate,
                          color: Colors.lightBlueAccent,//按钮的背景颜色
                          padding: EdgeInsets.all(10.100),//按钮距离里面内容的内边距
                          child: new Text('日期'),
                          textColor: Colors.black,//文字的颜色
                          textTheme:ButtonTextTheme.normal ,//按钮的主题
                          onHighlightChanged: (bool b){//水波纹高亮变化回调
                          },
                          splashColor: Colors.white,//水波纹的颜色
                          elevation: 5.0,//按钮下面的阴影
                        ),
                        new RaisedButton(
                          onPressed:showTime,
                          color: Colors.lightBlueAccent,//按钮的背景颜色
                          padding: EdgeInsets.all(10.100),//按钮距离里面内容的内边距
                          child: new Text('时间'),
                          textColor: Colors.black,//文字的颜色
                          textTheme:ButtonTextTheme.normal ,//按钮的主题
                          onHighlightChanged: (bool b){//水波纹高亮变化回调
                          },
                          splashColor: Colors.white,//水波纹的颜色
                          elevation: 5.0,//按钮下面的阴影
                        ),
                      ]
                  ),




                ],
            )
          ),
      );
    }

    Future<Null> seclectTime(BuildContext context) async{
           DateTime pick=await showDatePicker(context: context,
              initialDate: clickDate,
              firstDate: new DateTime(2017),
              lastDate: new DateTime(2050));

          if(pick !=null){
            setState(() {
              clickDate=pick;
            });
          }
    }

    Future<Null> seclectTime2(BuildContext context) async{
       TimeOfDay pick=await showTimePicker(context: context, initialTime: new TimeOfDay.now());
      if(pick!=null){
        setState(() {
          clickTime=pick;
        });
      }
    }

    void showDate(){
      seclectTime(context);
    }

    void showTime(){
      seclectTime2(context);
    }
}

