import 'package:flutter/material.dart';
import 'Model.dart';
import 'Utilities.dart';

class GoalTemplatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabState();

}

class _TabState extends State<GoalTemplatePage>
    with SingleTickerProviderStateMixin {

  TabController _tabController;
  TextEditingController _bookNameCtrl = TextEditingController();
  TextEditingController _bookPageCtrl = TextEditingController();
  TextEditingController _weightCtrl = TextEditingController();

  TimeOfDay _time;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _bookNameCtrl.dispose();
    _bookPageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text("选择目标模板"),
        backgroundColor: Colors.grey,
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.amber,
          tabs: <Widget>[
            new Tab(icon: Icon(Icons.book)),
            new Tab(icon: Icon(Icons.airline_seat_flat)),
            new Tab(icon: Icon(Icons.accessibility)),
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        bottomOpacity: 1,
      ),
      body: _backgroundStack(TabBarView(
        children: <Widget>[
          _universalStack(_readingPlan()),
          _universalStack(_sleepingPlan()),
          _universalStack(_weightingPlan()),
        ],
        controller: _tabController,
      )),
    );
  }




Widget _backgroundStack(Widget widget) {
  return new Stack(
    children: <Widget>[

      ConstrainedBox(
        child: Image.asset(
          "image/start_background2.jpg",
          fit: BoxFit.cover,
        ),
        constraints: new BoxConstraints.expand(),
      ),
      widget,
    ],
  );
}


  Widget _universalStack(Widget widget) {
    return new Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(bottom: 64),
          alignment: Alignment.bottomCenter,
          child: RaisedButton(
            onPressed: _gotoTimeSelectingPage,
            child: Text(
              'Next',
              style: TextStyle(
                  fontSize: 32,
                  fontFamily: 'Lobster'
              ),
            ),
          ),
        )
        , widget
      ],
    );
  }

  Widget _readingPlan() {
    return new Container(
      padding: EdgeInsets.fromLTRB(64.0, 64.0, 64.0, 0),
      child: Column(
        children: <Widget>[
          new Text(
            '读书计划',
            style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lobster'
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _labelConstructor("书名"),
              Flexible(
                  child:TextField(
                    controller: _bookNameCtrl,
                    decoration: InputDecoration(
                        hintText: "请输入书名"
                    ),
                  )
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _labelConstructor('页数'),
              Flexible(
                child: TextField(
                  controller: _bookPageCtrl,
                  decoration: InputDecoration(
                      hintText: '请输入页数'
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  // TODO: need a validator
                ),
              )

            ],
          )
        ],
      ),
    );
  }

  Widget _sleepingPlan()
  {
    return new Container(
      padding: EdgeInsets.fromLTRB(64.0, 100.0, 64.0, 0),
      child: Column(
        children: <Widget>[
          new Text(
            '睡觉计划',
            style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lobster'
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _labelConstructor("睡觉时间"),
              Flexible(
                  child:RaisedButton(
                      onPressed: _selectTime,
                      child: _time == null ?
                          new Text("点击输入时间", style: TextStyle(fontSize: 12),)
                          : new Text(_time.hour.toString()+":"+_time.minute.toString(), style: TextStyle(fontSize: 18),),
                  )
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _weightingPlan()
  {
    return new Container(
      padding: EdgeInsets.fromLTRB(64.0, 100.0, 64.0, 0),
      child: Column(
        children: <Widget>[
          new Text(
            '体重计划',
            style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lobster'
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _labelConstructor("体重"),
              Flexible(
                  child:TextField(
                    controller: _weightCtrl,
                    decoration: InputDecoration(
                        hintText: "请输入目标体重"
                    ),
                    keyboardType: TextInputType.number,
                  )
              ),
              Text("kg", style: new TextStyle(fontSize: 18),),
            ],
          ),
        ],
      ),
    );
  }

  Widget _labelConstructor(String str) {
    return Container(
      padding: EdgeInsets.only(right: 32),
      child: Text(
        str,
        style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  void _selectTime() async
  {
    final TimeOfDay _picked = await showTimePicker(
        context: context,
        initialTime: new TimeOfDay.now(),
    );

    if(_picked != null)
    {
      setState(() {
        _time = _picked;
      });
    }
  }

  void _gotoTimeSelectingPage() {
    if (_tabController.index == 0) {  // reading plan is chosen
      Model().setBookName(_bookNameCtrl.text);
      Model().setBookPages(_bookPageCtrl.text);
      Model().setGoalType("reading");
    }
    else if (_tabController.index == 1) {  // reading plan is chosen

      Model().setGoalType("sleeping");
    }
    else if (_tabController.index == 2) {  // reading plan is chosen

      Model().setGoalType("weighting");
    }
    Navigator.of(context).pushNamed('/goaltimepage');
  }
}
