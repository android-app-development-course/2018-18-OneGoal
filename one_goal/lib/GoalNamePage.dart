import 'package:flutter/material.dart';
import 'package:one_goal/Model.dart';
//import 'package:image/image.dart';

class GoalNamePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _GoalNamePageState();
}

class _GoalNamePageState extends State<GoalNamePage> {
  final textFieldController = TextEditingController();

  @override
  void dispose() {
    textFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: new Stack(
          children: [
            Image.asset("image/start_background2.jpg", fit: BoxFit.cover),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _oneGoalText(),
                _nameInput(),
                _nextButton(context)
              ],
            )
          ]
      ),
    );
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
              controller: textFieldController,
            )
        )
    );
  }

  Widget _nextButton(BuildContext context) {
    return new Expanded(
        child: new Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(bottom: 32.0),
          child: new RaisedButton(
            onPressed: () {
              if (textFieldController.text.length != 0) {
                Model().setGoalName(textFieldController.text);
                Navigator.of(context).pushNamed('/goaltemplatepage');
              }
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

}
