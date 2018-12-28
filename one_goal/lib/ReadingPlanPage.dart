import 'package:flutter/material.dart';
import 'package:one_goal/Setting.dart';
import 'ModelReadingNote.dart';
import 'Model.dart';
import 'ReadingNoteDetailPage.dart';

class ReadingPlanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReadingPlanState();
}

class _ReadingPlanState extends State<ReadingPlanPage> {
  List<ReadingNote> notes;

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
          return snapshot.hasData ? _scaffold():
            Center( child: Text(
                snapshot.toString(),
              style: TextStyle(
                fontSize: 10
              ),
            )  // TODO: change to progress bar
            );
        }
    );
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
      body: Column(children: [
        _buildBookName(),   // fixme: needs beautify
        _progressBar(),
        _eventListView(),
//        _addNoteButton(),
      ]),
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
      child: Text(Model().getBookName(),
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _progressBar() {
    return new Column(children: [
      LinearProgressIndicator(value: _getCurrentPage() / _getBookPages()),
      Text('完成度(${_getCurrentPage()}/${_getBookPages()})')
    ]);
  }

  void _onAddNoteButtonClicked(BuildContext context) {
    Navigator.of(context).pushNamed('/readingnotedetailpage');
  }

  void _onNoteTileTapped(BuildContext context, int index) {
    var note = notes[index];
    Navigator.of(context).push(
      new MaterialPageRoute(builder: (context) =>
        new ReadingNoteDetailPage(note.id))
    );
  }

  Widget _emptyInfo() {
    return Container(
      padding: const EdgeInsets.all(16.0),
        child: Text('你还没有添加笔记')
    );
  }

  Widget _eventListView() {
    return Container(
      height: 300,
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
            trailing:Icon(Icons.arrow_forward_ios),
            onTap: () => _onNoteTileTapped(context, index),
          ),

        ],
      ),
    );

  }

  Future<bool> _prepareData() async {
    notes = await Model().getAllReadingNotes();
    return true;
  }



  Widget _addNoteButton() {
    return Expanded(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      RaisedButton(
        onPressed: null,
        color: Colors.grey,
        child: Text(
          '添加笔记',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      )
    ]));
  }
}
