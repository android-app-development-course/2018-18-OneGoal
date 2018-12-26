import 'package:flutter/material.dart';

class GoalTimePage extends StatefulWidget
{
  GoalTimePage({Key key}): super(key: key);

  @override
  TimeState createState() => new TimeState();
}



class TimeState extends State<GoalTimePage> {

  DateTime StartDate=new DateTime.now();
  DateTime EndDate=new DateTime.now();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("选择时间"),
      ),
      body: new Container(
          margin: const EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 10.0),
          child: new Column(
            children: <Widget>[

              new Padding(
                padding: const EdgeInsets.all(50.0),

              ),


                    new ListTile(
                        onTap: () {
                          print('点击');
                        },
                        title: new Text(StartDate.toString().substring(0,10), style: new TextStyle(fontWeight: FontWeight.w500)),
                        leading: new Icon(
                          Icons.airline_seat_individual_suite,
                          color: Colors.blue[500],
                        ),
                      trailing:new Text("选择开始时间", style: new TextStyle(fontWeight: FontWeight.w500)),
                    ),


                    new ListTile(
                        onTap: () {
                          print('点击');
                        },
                        title: new Text(EndDate.toString().substring(0,10), style: new TextStyle(fontWeight: FontWeight.w500)),
                        leading: new Icon(
                          Icons.airline_seat_individual_suite,
                          color: Colors.blue[500],
                        ),
                        trailing:new Text("选择结束时间", style: new TextStyle(fontWeight: FontWeight.w500)),
                    ),


              new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    new RaisedButton(
                      onPressed:(){showDate2();},
                      color: Colors.lightBlueAccent,//按钮的背景颜色
                      padding: EdgeInsets.all(10.100),//按钮距离里面内容的内边距
                      child: new Text('开始日期'),
                      textColor: Colors.black,//文字的颜色
                      textTheme:ButtonTextTheme.normal ,//按钮的主题
                      onHighlightChanged: (bool b){//水波纹高亮变化回调
                      },
                      splashColor: Colors.white,//水波纹的颜色
                      elevation: 5.0,//按钮下面的阴影
                    ),

                    new RaisedButton(
                      onPressed:(){showDate();},
                      color: Colors.lightBlueAccent,//按钮的背景颜色
                      padding: EdgeInsets.all(10.100),//按钮距离里面内容的内边距
                      child: new Text('结束日期'),
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

  void showDate(){
    seclectTime(context);
  }

  void showDate2(){
    seclectTime2(context);
  }

  Future<Null> seclectTime(BuildContext context) async{
    DateTime pick=await showDatePicker(context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2017),
        lastDate: new DateTime(2050));

    if(pick !=null){
      setState(() {
        EndDate=pick;
      });
    }
  }

  Future<Null> seclectTime2(BuildContext context) async{
    DateTime pick=await showDatePicker(context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2017),
        lastDate: new DateTime(2050));

    if(pick !=null){
      setState(() {
        StartDate=pick;
      });
    }
  }



}
