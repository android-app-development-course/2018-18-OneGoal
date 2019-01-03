import 'package:flutter/material.dart';
import 'ModelReadingNote.dart';
import 'Model.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ReadingNoteDetailPage extends StatefulWidget {
  final int noteId;
  ReadingNoteDetailPage(this.noteId, {Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() => _ReadingNodeDetailState(noteId);

}

class _ReadingNodeDetailState extends State<ReadingNoteDetailPage> {
  final int noteId;
  bool dataLoaded = false;
  String _title = "";
  String _content = "";
  TextEditingController _titleCtrl = new TextEditingController();
  TextEditingController _contentCtrl = new TextEditingController();

  File _image;

  _ReadingNodeDetailState(this.noteId);

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    print(image.path);
    setState(() => _image = image);
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _contentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _prepareData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        ReadingNote note = snapshot.requireData;
        if (note != null && note.id != null && !dataLoaded) {
          _titleCtrl.text = note.title;
          _contentCtrl.text = note.content;
          dataLoaded = true;
        }
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
                  _buildContentTextField(),
//                   fixme: push confirm button to the bottom of screen
//                  _buildPictureGallery(),
                  _buildImageBox(),
                  _buildConfirmButton(),
                ],
              )),
          floatingActionButton: FloatingActionButton(
              onPressed: _onCameraButtonClicked,
            child: Icon(Icons.add_a_photo),
          ),
        );
      },
    );
  }

  Widget _buildTitle(String title) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Text(title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTitleTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: TextField(
        controller: _titleCtrl,
        onSubmitted: (String str) {
          _titleCtrl.text = str;

        },
        decoration: InputDecoration(
            border: OutlineInputBorder()
        ),
      ),
    );
  }
  Widget _buildContentTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: TextField(
        controller: _contentCtrl,
        //onChanged: (str) => _content = str,
        keyboardType: TextInputType.multiline,
        maxLines: 8,
        decoration: InputDecoration(
          border: OutlineInputBorder()
        ),
      ),
    );
  }

  Widget _buildImageBox() {
    return Center(
      child: GestureDetector(
        child: Container(
          width: 100,
          height: 100,
          child: _image == null ? Text('no image') : Image.file(_image),
        ),
        onTap: _image == null ? null : _onImageTapped),
    );
  }

  void _onImageTapped() async {
    await showDialog(
        context: context,
      builder: (buildContext) {
          return Dialog(
            child: Image.file(_image),
          );
      },
    );
  }

  Widget _buildConfirmButton() {
    return Container(
      padding: EdgeInsets.all(18.0),
        child:
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          RaisedButton(
            onPressed: _titleCtrl.text.isEmpty ? null
                : () {
              _confirmAddNoteButtonPressed(context);
            },
            color: Colors.grey,
            child: Text(
              noteId == null ? '确定添加' : '确定修改',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          )
        ]));
  }

  Widget _buildPictureGallery() {
    return new CarouselSlider(
        items: [1,2,3,4,5].map((i) {
          return new Builder(
            builder: (BuildContext context) {
              return new Container(
                  width: MediaQuery.of(context).size.width,
                  margin: new EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: new BoxDecoration(
                      color: Colors.amber
                  ),
                  child: new Text('text $i', style: new TextStyle(fontSize: 16.0),)
              );
            },
          );
        }).toList(),
        height: 150.0,
        autoPlay: true
    );
  }

  void _onCameraButtonClicked() {
    getImage();
  }

  void _confirmAddNoteButtonPressed(BuildContext context) {
    var newNote = new ReadingNote(
        title: _titleCtrl.text,
        content: _contentCtrl.text
    );
    if (noteId == null) {
      Model().insertReadingNote(newNote);
    } else {
      newNote.id = noteId;
      Model().updateReadingNote(newNote);
    }

    Navigator.pop(context);
  }

  Future<ReadingNote> _prepareData() async {
    if (noteId == null) return new ReadingNote();
    return await Model().getReadingNote(noteId);
  }
}