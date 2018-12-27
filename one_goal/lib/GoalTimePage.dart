import 'package:flutter/material.dart';
import 'package:one_goal/ReadingPlanPage.dart';

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
        backgroundColor: Colors.grey,
      ),
      body:new Stack(
          children: [
            ConstrainedBox(
              child: Image.asset(
                "image/start_background2.jpg",
                fit: BoxFit.cover,
              ),
              constraints: new BoxConstraints.expand(),
            ),
            new Container(
                margin: const EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 10.0),
                child: new Column(
                  children: <Widget>[

                    new Padding(
                      padding: const EdgeInsets.all(50.0),

                    ),


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
                      title: new Text(StartDate.toString().substring(0,10), style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500)),
                      leading: new Icon(
                        Icons.airline_seat_individual_suite,
                        color: Colors.grey[500],
                        size: 30,
                      ),
                      trailing:new Text("选择开始时间", style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500)),
                    ),

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
                      title: new Text(EndDate.toString().substring(0,10), style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500)),
                      leading: new Icon(
                        Icons.airline_seat_individual_suite,
                        color: Colors.grey[500],
                        size: 30,
                      ),
                      trailing:new Text("选择结束时间", style: new TextStyle(fontSize: 15.0,fontWeight: FontWeight.w500)),
                    ),

                    
                    new RaisedButton(
                      onPressed: _finish,
                      child: Text(
                        'Finish',
                        style: TextStyle(
                            fontSize: 32.0,
                            fontFamily: 'Lobster'
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ]
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

  void _finish()
  {
    Navigator.of(context).pushAndRemoveUntil(
        new MaterialPageRoute(builder: (context) => new ReadingPlanPage()),
            (Route route) => route ==null
    );
  }

}
