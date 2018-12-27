import 'package:flutter/material.dart';
import 'package:one_goal/ReadingPlanPage.dart';
import 'Model.dart';

class GoalTimePage extends StatefulWidget
{
  GoalTimePage({Key key}): super(key: key);

  @override
  TimeState createState() => new TimeState();
}

class TimeState extends State<GoalTimePage> {

  DateTime startDate = new DateTime.now();
  DateTime endDate = new DateTime.now();
  String _errMsg = "";  // TODO: show an error message if input is invalid

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("选择时间"),
        backgroundColor: Colors.grey,
      ),
      body: new Container(
          margin: const EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 10.0),
          child: new Column(
            children: <Widget>[

              new Padding(
                padding: const EdgeInsets.all(50.0),

              ),

             /* new Expanded(
                  child: new Container(
                   alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: new Text(
                      '开始时间',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lobster'
                      ),
                    ),
                  )),*/

              new Text(
                  'StartTime',
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lobster'
                  )
              ),

                    new ListTile(
                        onTap: showDate2,
                        title: new Text(startDate.toString().substring(0,10), style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500)),
                        leading: new Icon(
                          Icons.airline_seat_individual_suite,
                          color: Colors.grey[500],
                          size: 30,
                        ),
                      trailing:new Text("选择开始时间", style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500)),
                    ),


            /*  new Expanded(
                  child: new Container(
                    alignment: Alignment.topCenter,
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: new Text(
                      '结束时间',
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Lobster'
                      ),
                    ),
                  )),*/

            new Text(
              'EndTime',
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lobster'
              )
            ),

                    new ListTile(
                        onTap:showDate,
                        title: new Text(endDate.toString().substring(0,10), style: new TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500)),
                        leading: new Icon(
                          Icons.airline_seat_individual_suite,
                          color: Colors.grey[500],
                          size: 30,
                        ),
                        trailing:new Text("选择结束时间", style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500)),
                    ),



              new RaisedButton(
                onPressed: !_inputIsValidate() ? null : _finish,
                child: Text(
                  'Finish',
                  style: TextStyle(
                      fontSize: 32.0,
                      fontFamily: 'Lobster'
                  ),
                ),
              ),

            /*  new Row(
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
              ),*/



            ],
          )
      ),
    );

  }

  void showDate(){
    selectTime(context);
  }

  void showDate2(){
    seclectTime2(context);
  }

  Future<Null> selectTime(BuildContext context) async{
    DateTime pick=await showDatePicker(context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2017),
        lastDate: new DateTime(2050));


    if(pick !=null){
      setState(() {
        endDate=pick;
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
        startDate=pick;
      });
    }
  }

  void _finish()
  {
    Model().setInitialized();
    String goalType = Model().getGoalType();
    String pageName;
    switch (goalType) {
      case Model.READ: pageName = "/readingplanpage"; break;
      case Model.SLEEP: pageName = "/unsupported"; break;  // TODO: make it support
      case Model.WEIGHT: pageName = "/unsupported"; break; // TODO: make it support
    }
    Navigator.of(context).pushNamedAndRemoveUntil(pageName,
            (Route route) => route == null);
  }

  bool _inputIsValidate() {
    return startDate.compareTo(endDate) < 0;
  }

}
