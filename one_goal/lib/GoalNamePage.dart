import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoalNamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
       body: new Stack(
         children: [
           Image.asset("image/background.jpg", fit: BoxFit.cover),
           Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: <Widget>[
               _oneGoalText(),
               _nameInput(),
               _nextButton()
             ],
           )
         ]
       ),
    );
  }
}

Widget _oneGoalText() {
  return new Expanded(
      child: new Container(
    alignment: Alignment.bottomCenter,
    padding: const EdgeInsets.only(bottom: 32.0),
    child: new Text(
      'OneGoal',
      style: TextStyle(
        fontSize: 48.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Lobster'
      ),
    ),
  ));
}

Widget _nameInput() {
  return new Expanded(
    child: new Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: new TextField(
        decoration: InputDecoration(hintText: 'Please input your goal name.'),
        textAlign: TextAlign.center,
        onSubmitted: (String str) {
          _saveName(str);
        },
      )
    )
  );
}

Widget _nextButton() {
  return new Expanded(
      child: new Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(bottom: 32.0),
        child: new RaisedButton(
          onPressed: () {
            // TODO: go to next page
          },
          child: Text(
            'Next',
            style: TextStyle(
              fontSize: 32.0,
              fontFamily: 'Lobster'
            ),
          ),
        ),
      )
  );
}

//将任务名称保存到'goalName'中
void _saveName(String name) async
{
  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.setString('goalName', name);
}