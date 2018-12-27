import 'package:flutter/material.dart';
import 'ModelReadingNote.dart';
import 'Model.dart';

class ReadingNoteDetailPage extends StatefulWidget {
  final int noteId;
  ReadingNoteDetailPage(this.noteId, {Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() => _ReadingNodeDetailState(noteId);

}

class _ReadingNodeDetailState extends State<ReadingNoteDetailPage> {
  final int noteId;
  String _title = "";
  String _content = "";

  _ReadingNodeDetailState(this.noteId);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _prepareData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return !snapshot.hasData ? Center(child: CircularProgressIndicator()) :
        Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            backgroundColor: Colors.grey,
            title: Text('我的笔记'),
          ),
          body: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildTitle('标题'),
                  _buildTitleTextField(),
                  _buildTitle('内容'),
                  _buildContentTextField(),  // fixme: make a border
                  // fixme: push confirm button to the bottom of screen
                  _buildConfirmButton(),
                ],
              )),
        );
      },
    );
  }

  Widget _buildTitle(String title) {
    return Text(title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTitleTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: TextField(
        onChanged: (String str) => _title = str,
      ),
    );
  }
  Widget _buildContentTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: TextField(
        onChanged: (str) => _content = str,
        keyboardType: TextInputType.multiline,
        maxLines: 8,
        decoration: InputDecoration(
          border: InputBorder.none
        ),
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18),
        child:
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          RaisedButton(
            onPressed: _title.isEmpty ? null
                : () {
              _confirmAddNoteButtonPressed(context);
            },
            color: Colors.grey,
            child: Text(
              '确定添加',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          )
        ]));
  }

  Widget _buildPictureGallery() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          // TODO: feed images list data
        },
    );
  }

  void _confirmAddNoteButtonPressed(BuildContext context) {
    var newNote = new ReadingNote(
        title: _title,
        content: _content
    );
    if (noteId == null) {
      Model().insertReadingNote(newNote);
    } else {
      newNote.id = noteId;
      Model().updateReadingNote(newNote);
    }

    Navigator.pop(context);
  }

  Future<bool> _prepareData() async {
    if (noteId == null) return true;
    ReadingNote note = await Model().getReadingNote(noteId);
    _title = note.title;
    _content = note.content;
    return true;
  }
}