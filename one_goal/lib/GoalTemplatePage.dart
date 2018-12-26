import 'package:flutter/material.dart';

class GoalTemplatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabState();

}

class _TabState extends State<GoalTemplatePage>
    with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
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
          new Text("test"),
          new Text("test"),
        ],
        controller: _tabController,
      )),
    );
  }

}

Widget _backgroundStack(Widget widget) {
  return new Stack(
    children: <Widget>[
      Image.asset("image/start_background2.jpg",    // fixme: unable to fill the image
          fit: BoxFit.cover,
      ),
      widget
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
            onPressed: null,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _labelConstructor("书名"),
            Flexible(
                child:TextField(
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
                decoration: InputDecoration(
                    hintText: '请输入页数'
                ),
                keyboardType: TextInputType.number,
                maxLength: 6,
              ),
            )

          ],
        )
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