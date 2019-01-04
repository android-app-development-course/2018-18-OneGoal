import 'package:flutter/material.dart';
import 'ModelReadingNote.dart';
import 'Model.dart';
import 'ReadingNoteDetailPage.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';
import 'package:flutter/foundation.dart';

class ReadingPlanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReadingPlanState();
}

class _ReadingPlanState extends State<ReadingPlanPage> {
  List<ReadingNote> notes;
  double _sliderValue;
  double maxPage;
  bool dataLoaded = false;
  Future<List<ReadingNote>> readingNoteFuture;

  @override
  void initState() {
    readingNoteFuture = Model().getAllReadingNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: _prepareData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) return Center(
              child: Text(
                snapshot.toString(),
                style: TextStyle(fontSize: 10),
              )); // TODO: change to progress bar
          if (!dataLoaded) {
            _sliderValue = _getCurrentPage().toDouble();
            maxPage = double.parse(Model().getBookPages());
            notes = snapshot.data;
            dataLoaded = true;
          }

          return _scaffold();
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
        notes.isEmpty ? _emptyInfo() : _eventListView(),
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
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: RaisedButton(
          onPressed: () {},
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: EdgeInsets.only(left: 64, right: 64, top: 8, bottom: 16),
          child: Text(
            Model().getBookName(),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )
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
        padding: const EdgeInsets.all(16.0), child: Text('你还没有添加笔记，点击右下角添加'));
  }

  Widget _eventListView() {
    return Container(
      height: 320,
      margin: EdgeInsets.all(36),
      decoration: BoxDecoration(
        border: new Border.all(width: 2.0, color: Colors.black12)
      ),
      child: ListView.builder(
        //padding: const EdgeInsets.all(16.0),
        itemCount: notes.length,
//      itemExtent: 30,
//      shrinkWrap: true,
        itemBuilder: _buildEventListTile,

      ),
    );
  }

  Widget _buildEventListTile(BuildContext context, int index) {
    var item = notes[index];
    return new Container(
      child: new Column(
        children: <Widget>[
          Dismissible(
            key: new Key(item.id.toString()),
            child: ListTile(
              leading: Icon(Icons.done),
              title: Text(item.title),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () => _onNoteTileTapped(context, index),
            ),
            onDismissed: (direction) async {
              await Model().deleteReadingNote(item);
              setState(() => notes.removeAt(index));
              Scaffold.of(context).showSnackBar(
                new SnackBar(content: Text("${item.title} dismissed."))
              );
//              notes.removeAt(index);
              //dataLoaded = false;

            },
            background: new Container(
              color: Colors.red,
            ),
          ),

          new Divider(),
        ],
      ),
    );
  }

  Widget _buildBackground(Widget widget) {
    return Stack(
      children: [
        _waveWidget(),
        Container(
          //height: 500,
//          margin: EdgeInsets.only(bottom: 50),
          padding: EdgeInsets.fromLTRB(64, 450.0, 64, 0),
          alignment: Alignment.bottomCenter,
          //padding: EdgeInsets.symmetric(horizontal: 50),
          child: Slider(
              min: 0.0,
              max: maxPage,
              value: _sliderValue,
              onChanged: (newRating) {
                setState(() => _sliderValue = newRating);
                if (_sliderValue >= maxPage) {
                  _neverSatisfied();
                }
              },
              onChangeEnd: (value) =>
                Model().setCurrentBookPages(value.floor().toString()),
          ),

        ),
        widget,
      ],
    );
  }

  Widget _waveWidget() {
    var p = _sliderValue / maxPage;
    List<double> percentages = [1 - p, 0.97 - p, 0.95 - p, 0.9 - p];
    return WaveWidget(
      config: CustomConfig(
        gradients: [
          [Colors.blue, Color(0xEE00A5C7)],
          [Color(0xFF00C7F0), Color(0x554DE1FF)],
          [Color(0xFF66C7F0), Color(0x5599EEFF)],
          [Color(0xFF66E5FF), Color(0x5599EEFF)]
        ],
        durations: [35000, 19440, 10800, 6000],
        heightPercentages: percentages,
        blur: MaskFilter.blur(BlurStyle.solid, 10),
        gradientBegin: Alignment.bottomLeft,
        gradientEnd: Alignment.topRight,
      ),
      waveAmplitude: 0,
      backgroundColor: Colors.white,
      size: Size(
        double.infinity,
        double.infinity,
      ),
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
                Navigator.pushNamedAndRemoveUntil(context, '/resultofreading',
                    (Route route) => route == null);
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

  Future<List<ReadingNote>> _prepareData() async {
    return await readingNoteFuture;
  }

  int _getBookPages() {
    return int.parse(Model().getBookPages());
  }

  int _getCurrentPage() {
    return int.parse(Model().getCurrentBookPages());
  }
}
