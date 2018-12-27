import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart'as charts;
import 'package:one_goal/Model.dart';

class ResultOfReading extends StatefulWidget
{
  ResultOfReading({Key key}): super(key: key);

  @override
  ResultOfReadingState createState() => new ResultOfReadingState();
}



class ResultOfReadingState extends State<ResultOfReading> {

  bool animate=false;
  List<charts.Series<TimeSeriesSales, DateTime>> seriesList=_createSampleData();


  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData(){
    final data = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 14),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 30),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 50),
      new TimeSeriesSales(new DateTime(2017, 10, 15), 75),
      new TimeSeriesSales(new DateTime(2017, 11, 18), 92),
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.grey,
        title: new Text("读书计划"),
      ),
      body: new Container(
          margin: const EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 10.0),
          child: new Column(
            children: <Widget>[

              new Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: new Text("完成度显示"),
              ),
              new Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  height: 300.0,
                  child: new charts.TimeSeriesChart(
                    seriesList,
                    animate: animate,
                    dateTimeFactory: const charts.LocalDateTimeFactory(),)
              ),

              new Text("开始时间："+dateTime2String(Model().getBeginDateTime())),
              new Text("结束时间："+dateTime2String(Model().getEndDateTime())),


            ],
          )
      ),
    );
  }

  String dateTime2String(DateTime time)
  {
    return time.year.toString()+"-"
        +time.month.toString()+"-"
        +time.day.toString()+" "
        +time.hour.toString()+":"
        +time.minute.toString()+":"
        +time.second.toString();
  }

}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}