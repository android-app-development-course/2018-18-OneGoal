import 'package:flutter/material.dart';
import 'Model.dart';

class GoalTemplatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TabState();

}

class _TabState extends State<GoalTemplatePage>
    with SingleTickerProviderStateMixin {

  TabController _tabController;
  TextEditingController _bookNameCtrl = TextEditingController();
  TextEditingController _bookPageCtrl = TextEditingController();

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
          new Text("test"),
          new Text("test"),
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

  void _gotoTimeSelectingPage() {
    if (_tabController.index == 0) {  // reading plan is chosen
      Model().setBookName(_bookNameCtrl.text);
      Model().setBookPages(_bookPageCtrl.text);
      Navigator.of(context).pushNamed('/goaltimepage');
    }
  }
}
