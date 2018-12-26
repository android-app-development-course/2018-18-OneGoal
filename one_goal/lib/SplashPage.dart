import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:one_goal/main.dart';
import 'package:one_goal/GoalNamePage.dart';
import 'package:one_goal/GuidePage.dart';
import 'package:one_goal/Model.dart';

class SplashPage extends StatefulWidget
{
  SplashPage({Key key}): super(key: key);

  @override
  SplashPageState createState() => new SplashPageState();
}

class SplashPageState extends State<SplashPage>
{
  bool isStartHomePage = false;
  bool isGuidePage = false;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: goToHomePage,
      child: Image.asset("image/splash_img.png", fit: BoxFit.cover),
    );
  }

  @override
  void initState()
  {
    super.initState();
    isGuidePage = Model().isInitializing();
    //开启倒计时
    var duration = Duration(seconds: 3);
    new Future.delayed(duration, goToHomePage);
  }

  @override
  void dispose()
  {
    super.dispose();
  }

  void goToHomePage()
  {
    //如果页面未跳转过则跳转页面
    if(!isStartHomePage)
    {
      if(isGuidePage)
      {//跳转主页，销毁当前页面
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(builder: (context) => new GoalNamePage()),
            (Route route) => route ==null
        );
      }
      else
      {//跳转引导页，销毁当前页面
        Navigator.of(context).pushAndRemoveUntil(
            new MaterialPageRoute(builder: (context) => new GoalNamePage()),
            (Route route) => route ==null
        );
        Model().setInitialized();
      }
      isStartHomePage = true;
    }
  }

}
