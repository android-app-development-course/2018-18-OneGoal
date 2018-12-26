import 'package:flutter/material.dart';
import 'package:one_goal/SplashPage.dart';
import 'package:one_goal/GoalNamePage.dart';
import 'package:one_goal/GoalTemplatePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/rendering.dart';
import 'package:one_goal/WeightPlanPage.dart';
import 'package:one_goal/SleepingPlanPage.dart';
import 'package:one_goal/ReadingPlanPage.dart';
import 'package:one_goal/ReadingNoteDetailPage.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One Goal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new ReadingNoteDetailPage(),
      routes: <String, WidgetBuilder>{
        //'/HomePage': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        '/goalnamepage': (context) => GoalNamePage(),
        '/goaltemplatepage': (context) => GoalTemplatePage()
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new MaterialButton(
              onPressed: _reset,
              child: new Icon(Icons.minimize),
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }

  //test 用于重启后进入引导页面，可以用一个按钮来调用
  void _reset() async
  {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool("isGuidePage", false);
  }
}
