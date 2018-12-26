import 'package:flutter/material.dart';

class ReadingNoteDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ReadingNodeDetailState();

  ReadingNoteDetailPage({Key key}): super(key: key);
}

class _ReadingNodeDetailState extends State<ReadingNoteDetailPage> {
  String _title = "";
  String _content = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          _buildContentTextField(),
          Spacer(   // fixme: push confirm button to the bottom of screen
            flex: 2
          ),
          _buildConfirmButton(),
        ],
      )),
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
        onSubmitted: (String str) => _title = str,
      ),
    );
  }
  Widget _buildContentTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: TextField(
        onSubmitted: (String str) => _content = str,
        keyboardType: TextInputType.multiline,
        maxLines: 8,
      ),
    );
  }

  Widget _buildConfirmButton() {
    return Container(
        child:
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          RaisedButton(
            onPressed: null,
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
}