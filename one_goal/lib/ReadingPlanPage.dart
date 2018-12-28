import 'package:flutter/material.dart';
import 'package:one_goal/Setting.dart';
import 'ModelReadingNote.dart';
import 'Model.dart';
import 'ReadingNoteDetailPage.dart';
import 'dart:math';

class ReadingPlanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReadingPlanState();
}

class _ReadingPlanState extends State<ReadingPlanPage> {
  List<ReadingNote> notes;
  double _sliderValue = 10.0;
  int maxPage;

  int _getBookPages() {
    return int.parse(Model().getBookPages());
  }

  int _getCurrentPage() {
    return int.parse(Model().getCurrentBookPages());
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: _prepareData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? _scaffold()
              : Center(
                  child: Text(
                  snapshot.toString(),
                  style: TextStyle(fontSize: 10),
                ) // TODO: change to progress bar
                  );
        });
  }

  Widget _scaffold() {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('读书计划'),
        actions: <Widget>[
          new IconButton(
            color: Colors.white,
            icon: new Icon(Icons.settings),
            onPressed: () => Navigator.of(context).pushNamed('/setting'),
            tooltip: '设置',
          ),
        ],
      ),
      body: _buildBackground(Column(children: [
        _buildBookName(), // fixme: needs beautify
        _progressBar(),
        _eventListView(),
//        _addNoteButton(),
      ])),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: Icon(Icons.create),
            onPressed: () => _onAddNoteButtonClicked(context),
          )
        ],
      ),
    );
  }

  Widget _buildBookName() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Text(
        Model().getBookName(),
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _progressBar() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(children: [
          LinearProgressIndicator(value: _sliderValue / _getBookPages()),
          Text('完成度(${_sliderValue.floor()}/${_getBookPages()})')
        ]));
  }

  void _onAddNoteButtonClicked(BuildContext context) {
    Navigator.of(context).pushNamed('/readingnotedetailpage');
  }

  void _onNoteTileTapped(BuildContext context, int index) {
    var note = notes[index];
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (context) => new ReadingNoteDetailPage(note.id)));
  }

  Widget _emptyInfo() {
    return Container(
        padding: const EdgeInsets.all(16.0), child: Text('你还没有添加笔记'));
  }

  Widget _eventListView() {
    return Container(
      height: 300,
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: notes.length,
//      itemExtent: 30,
//      shrinkWrap: true,
        itemBuilder: _buildEventListTile,
      ),
    );
  }

  Widget _buildEventListTile(BuildContext context, int index) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Divider(),
          ListTile(
            leading: Icon(Icons.done),
            title: Text(notes[index].title),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () => _onNoteTileTapped(context, index),
          ),
        ],
      ),
    );
  }

  Widget _buildBackground(Widget widget) {
    return Stack(
      children: [
        Container(
          //height: 500,
//          margin: EdgeInsets.only(bottom: 50),
          padding: EdgeInsets.fromLTRB(64, 450.0, 64, 0),
          alignment: Alignment.bottomCenter,
          //padding: EdgeInsets.symmetric(horizontal: 50),
          child: Slider(
            min: 0.0,
            max: maxPage.toDouble(),
            value: _sliderValue,
            onChanged: (newRating) {
              setState(() => _sliderValue = newRating);
              if (_sliderValue >= maxPage) {
                _neverSatisfied();
              }
            }
          ),
        ),
        widget,
      ],
    );
  }

  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('任务完成'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('计划是否已完成？'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('是'),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context,
                    '/resultofreading', (Route route) => route == null);
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('否'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _prepareData() async {
    notes = await Model().getAllReadingNotes();
    maxPage = int.parse(await Model().getBookPages());
    return true;
  }
}
