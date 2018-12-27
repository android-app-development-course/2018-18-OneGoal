import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart'as charts;

class Reading extends StatefulWidget
{
  Reading({Key key}): super(key: key);

  @override
  ReadingState createState() => new ReadingState();
}



class ReadingState extends State<Reading> {

  List<charts.Series<TimeSeriesSales, DateTime>> seriesList=_createSampleData();
  bool animate=false;

  String kg="5";
  //get kg;
  int mission=0;
  int maxmission=100;


  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData(){
    final data = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 25),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 100),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 75),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }




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
          ),

              new Container(
                height: 300.0,
                child: new charts.TimeSeriesChart(
                  seriesList,
                  animate: animate,
                  dateTimeFactory: const charts.LocalDateTimeFactory(),)
              ),


              new RaisedButton(
                //onPressed:
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
                //onPressed:
                color: Colors.lightBlueAccent,//按钮的背景颜色
                padding: EdgeInsets.all(10.100),//按钮距离里面内容的内边距
                child: new Text('结束任务'),
                textColor: Colors.black,//文字的颜色
                textTheme:ButtonTextTheme.normal ,//按钮的主题
                onHighlightChanged: (bool b){//水波纹高亮变化回调
                },
                splashColor: Colors.white,//水波纹的颜色
                elevation: 5.0,//按钮下面的阴影
              ),



        ],
          )
      ),
    );



  }

}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}