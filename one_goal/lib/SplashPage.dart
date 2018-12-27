import 'package:flutter/material.dart';
import 'dart:async';
import 'package:one_goal/main.dart';
import 'package:one_goal/GoalNamePage.dart';
import 'package:one_goal/Model.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  @override
  SplashPageState createState() => new SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  bool hasInitialized;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: goToHomePage,
      child: ConstrainedBox(
        child: Image.asset(
          "image/splash_img.png",
          fit: BoxFit.cover,
        ),
        constraints: new BoxConstraints.expand(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    hasInitialized = Model().hasInitialized();
    //开启倒计时
    var duration = Duration(seconds: 3);
    new Future.delayed(duration, goToHomePage);
  }

  void goToHomePage() {
    if (hasInitialized) {
      //跳转主页，销毁当前页面 这里要根据所选计划跳转不同的页面
      String goalType = Model().getGoalType();
      String pageName;
      switch (goalType) {
        case Model.READ: pageName = "/readingplanpage"; break;
        case Model.SLEEP: pageName = "/unsupported"; break;  // TODO: make it support
        case Model.WEIGHT: pageName = "/unsupported"; break; // TODO: make it support
      }
      Navigator.of(context).pushNamedAndRemoveUntil(pageName,
              (Route route) => route == null);
    } else {
      //跳转引导页，销毁当前页面
      Navigator.of(context).pushNamedAndRemoveUntil("/goalnamepage",
          (Route route) => route == null);
    }
  }
}
