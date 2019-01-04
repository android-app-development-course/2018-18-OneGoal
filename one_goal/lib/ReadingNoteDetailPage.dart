import 'package:flutter/material.dart';
import 'ModelReadingNote.dart';
import 'Model.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tuple/tuple.dart';

class ReadingNoteDetailPage extends StatefulWidget {
  final int noteId;
  ReadingNoteDetailPage(this.noteId, {Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() => _ReadingNodeDetailState(noteId);
}

class _ReadingNodeDetailState extends State<ReadingNoteDetailPage> {
  final int noteId;
  bool dataLoaded = false;
  TextEditingController _titleCtrl = new TextEditingController();
  TextEditingController _contentCtrl = new TextEditingController();
  Future<ReadingNote> readingNoteFuture;
  Future<List<File>> imagesFuture;

  List<File> idImages = new List<File>();

  _ReadingNodeDetailState(this.noteId);

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() => idImages.add(image));
  }

  @override
  void initState() {
    // get all future
    readingNoteFuture = Model().getReadingNote(noteId);
    imagesFuture = Model().loadImages(noteId);
    super.initState();
  }

  Future<Map<String, dynamic>> _preparingData() async {
    var map = new Map<String, dynamic>();
    map['readingNote'] = await readingNoteFuture;
    map['images'] = await imagesFuture;
    return map;
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
      future: _preparingData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
        ReadingNote note = snapshot.data['readingNote'];
        List<File> images = snapshot.data['images'];
        print("get images length: " + images.length.toString());
        if (note != null && note.id != null && !dataLoaded) {
          _titleCtrl.text = note.title;
          _contentCtrl.text = note.content;
          idImages = images;
          dataLoaded = true;
        }
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
//                   fixme: push confirm button to the bottom of screen
                  _buildPictureGallery(),
//                  _buildImageBox(),
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

  void _onImageTapped(int index) async {
    await showDialog(
        context: context,
      builder: (buildContext) {
          return Dialog(
            child: Container(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Image.file(idImages[index]),
                  Align(
                    alignment: Alignment.topRight,
                    child: FloatingActionButton(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.red,
                      elevation: 0,
                      child: Icon(Icons.delete),
                    onPressed: () => _onPictureDeleteClicked(idImages[index]),
                  )),
                ],
              ),
            ),

          );
      },
    );
  }

  void _onPictureDeleteClicked(File image) {
    setState(() => idImages.remove(image));
    Model().deleteImage(noteId, image);
    Navigator.pop(context);
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
    if (idImages.isEmpty) return Center(child: Text('No image'));
    else return new CarouselSlider(
        viewportFraction: _dynamicViewportFraction(idImages.length),

        items: new List<int>.generate(idImages.length, (id) => id).map((i) {
          return new Builder(
            builder: (BuildContext context) {
              return new Container(
                  width: MediaQuery.of(context).size.width,
                  margin: new EdgeInsets.all(5.0),
//                  decoration: new BoxDecoration(
//                      color: Colors.amber
//                  ),
//                  child: new Text('text $i', style: new TextStyle(fontSize: 16.0),)
                  child: GestureDetector(
                    child: Image.file(idImages[i]),
                    onTap: () => _onImageTapped(i),
                  ),
              );
            },
          );
        }).toList(),
        height: 120.0,
        autoPlay: true
    );
  }

  void _onCameraButtonClicked() {
    getImage();
  }


  void _confirmAddNoteButtonPressed(BuildContext context) async {
    var newNote = new ReadingNote(
        title: _titleCtrl.text,
        content: _contentCtrl.text
    );
    if (noteId == null) {
      var id = await Model().insertReadingNote(newNote);
      Model().saveImages(id, idImages);
    } else {
      newNote.id = noteId;
      Model().updateReadingNote(newNote);
      Model().saveImages(noteId, idImages);
    }

    Navigator.pop(context);
  }

  double _dynamicViewportFraction(int imageNum) {
    return imageNum < 3 ? 0.8 : 0.3;
  }
}