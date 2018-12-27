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
import 'package:one_goal/Setting.dart';
import 'package:one_goal/Model.dart';
import 'package:one_goal/GoalTimePage.dart';
import 'package:one_goal/ResultOfReading.dart';

void main() async {
  //debugPaintSizeEnabled = true;
  await Model().init();   // fixme: weird explicit initialization
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
      home: new ResultOfReading(),
      routes: <String, WidgetBuilder> {
        //'/HomePage': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        '/goalnamepage': (context) => GoalNamePage(),
        '/goaltemplatepage': (context) => GoalTemplatePage(),
        '/goaltimepage': (context) => GoalTimePage(),
        '/readingplanpage': (context) => ReadingPlanPage(),
        '/readingnotedetailpage': (context) => ReadingNoteDetailPage(null),
        '/setting': (context) => Setting(),
      }
    );
  }
}
