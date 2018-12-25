import 'package:flutter/material.dart';


class ReadingPlanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReadingPlanState();
}

class _ReadingPlanState extends State<ReadingPlanPage> {

  int _getBookPages() {
    return 100;   // TODO: connect to database
  }
  int _getCurrentPage() {
    return 56;
  }
  String _getBookName() {
    return "Compiler: principle...";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('读书计划'),
      ),
      body: Column(
       children: [
         _progressBar(),
         Text(_getBookName()),
         _eventListView(),
         _addNoteButton(),
      ]
      ),
    );
  }

  Widget _progressBar() {
    return new Column(
        children: [
          LinearProgressIndicator(value: _getCurrentPage()/_getBookPages()),
          Text('完成度(${_getCurrentPage()}/${_getBookPages()})')
        ]
    );

  }

  Widget _eventListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: _mockEvents.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return _buildEventListTile(index);
      },
    );
  }

  Widget _buildEventListTile(int i) {
    return ListTile(
      leading: Icon(Icons.done),
      title: Text(_mockEvents[i]),

    );
  }

  List<String> _mockEvents = [
    "Start reading",
    "Finish the first chapter",
    "Done homework"
  ];

  Widget _addNoteButton() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: 32),
        alignment: Alignment.bottomCenter,
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column (
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
              onPressed: null,
              color: Colors.grey,
              child: Text('添加笔记',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ]
        )
      ),
    );
  }

}