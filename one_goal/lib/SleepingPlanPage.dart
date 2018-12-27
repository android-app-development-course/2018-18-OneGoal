import 'package:flutter/material.dart';
import 'package:one_goal/Model.dart';
import 'package:one_goal/ModelSleepingNote.dart';

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
    SleepingNote newone=new SleepingNote();


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
        print(title);
      });
    }

    void titleChange2(String str){
      setState(() {
        content =str;
        print(content);
      });
    }

    List<SleepingNote> _mockEvents=new List<SleepingNote>();

    Widget _buildEventListTile(int i) {
      return/*ListTile(
        leading: Icon(Icons.done),
        title: Text(_mockEvents[i]),
      );*/

         ListTile(
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
                          new Padding( padding: const EdgeInsets.all(10.0),),
                          new Text(_mockEvents[i].date.toString().substring(0,10), style: new TextStyle(fontWeight: FontWeight.w500)),
                          new Text(_mockEvents[i].time.toString().substring(10,15), style: new TextStyle(fontWeight: FontWeight.w500)),
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
            title: new Text(_mockEvents[i].title, style: new TextStyle(fontWeight: FontWeight.w500)),
            subtitle: new Text(_mockEvents[i].content),
            leading: new Icon(
              Icons.business,
              color: Colors.blue[500],
            )
        );

    }

    Future<bool> _mockDatabase() async {
      _mockEvents =await Model().getAllSleepingNotes();
      //print(_mockEvents.length);
      return true;
    }

    @override
    Widget build(BuildContext context) {

      return new FutureBuilder(
//      future: Model().getAllReadingNotes().then((ns) => notes = ns),
          future: _mockDatabase(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return new Scaffold(
              resizeToAvoidBottomPadding: false,
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



             ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: _mockEvents.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return _buildEventListTile(index);
                },
              ),


                      new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            new RaisedButton(
                              onPressed:(){
                                //
                                //Model.
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
                                            new Padding( padding: const EdgeInsets.all(10.0),),
                                            new Text(clickDate.toString().substring(0,10), style: new TextStyle(fontWeight: FontWeight.w500)),
                                            new Text(clickTime.toString().substring(10,15), style: new TextStyle(fontWeight: FontWeight.w500)),
                                          ],
                                        ),
                                      ),
                                      actions: <Widget>[
                                        new FlatButton(
                                          child: new Text('确定'),
                                          onPressed: () {

                                            newone.time=clickTime;
                                            newone.date=clickDate;
                                            newone.title=title;
                                            newone.content=content;
                                            Model().insertSleepingNote(newone);

                                            setState(() {

                                            });


                                            Navigator.of(context).pop();
                                          },
                                        ),

                                        new FlatButton(
                                            child: new Text('返回'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            }
                                        ),
                                      ],
                                    );
                                  },
                                ).then((val) {
                                  print(val);
                                });
                              },
                              color: Colors.lightBlueAccent,//按钮的背景颜色
                              padding: EdgeInsets.all(10.100),//按钮距离里面内容的内边距
                              child: new Text('添加'),
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

