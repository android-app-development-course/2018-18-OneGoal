import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart'as charts;

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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("读书计划"),
      ),
      body: new Container(
          margin: const EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 10.0),
          child: new Column(
            children: <Widget>[

              new Text("完成度显示"),
              new Container(
                  height: 300.0,
                  child: new charts.TimeSeriesChart(
                    seriesList,
                    animate: animate,
                    dateTimeFactory: const charts.LocalDateTimeFactory(),)
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