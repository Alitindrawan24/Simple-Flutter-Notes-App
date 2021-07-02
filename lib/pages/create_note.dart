import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_notes_app/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class CreateNote extends StatefulWidget {
  const CreateNote(this.id, {Key? key}) : super(key: key);
  final String id;

  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  late Note list;
  // ignore: prefer_final_fields
  TextEditingController _titlecontroller = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _contentcontroller = TextEditingController();

  bool titleValidate = true;
  bool contentValidate = true;

  @override
  dispose() {
    _titlecontroller.dispose();
    _contentcontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.id.isNotEmpty) {
      getNoteById(widget.id);
    }
  }

  void getNoteById(String itemId) async {
    final prefs = await SharedPreferences.getInstance();
    List<Note> temp = <Note>[];

    if (prefs.containsKey('notes')) {
      final myNote = json.decode(prefs.getString('notes') ?? "");
      temp = (myNote as List).map((item) => Note.fromJson(item)).toList();
    }

    for (var element in temp) {
      if (element.id == itemId) {
        list = element;
        _titlecontroller.text = element.title;
        _contentcontroller.text = element.content;
      }
    }
  }

  void saveNote() async {
    if (validateInput()) {
      final prefs = await SharedPreferences.getInstance();
      List<Note> temp = <Note>[];

      if (prefs.containsKey('notes')) {
        final myNote = json.decode(prefs.getString('notes') ?? "");
        temp = (myNote as List).map((item) => Note.fromJson(item)).toList();
        prefs.clear();
      }

      if (widget.id.isNotEmpty) {
        for (var element in temp) {
          if (element.id == widget.id) {
            int index = temp.indexOf(element);
            temp[index].title = _titlecontroller.text;
            temp[index].content = _contentcontroller.text;
          }
        }
      } else {
        Note newNote = Note(
          id: const Uuid().v1().toString(),
          title: _titlecontroller.text,
          content: _contentcontroller.text,
          createdAt: DateTime.now().microsecondsSinceEpoch.toString(),
        );

        temp.insert(0, newNote);
      }
      prefs.setString('notes', json.encode(temp));
      Navigator.pop(context);
    }
  }

  bool validateInput() {
    _titlecontroller.text.isEmpty
        ? titleValidate = false
        : titleValidate = true;
    _contentcontroller.text.isEmpty
        ? contentValidate = false
        : contentValidate = true;

    setState(() {});

    if (titleValidate && contentValidate) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Catatan",
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                  controller: _titlecontroller,
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: InputDecoration(
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                    fillColor: Colors.black,
                    border: const OutlineInputBorder(),
                    labelText: 'Judul Catatan',
                    errorText: titleValidate
                        ? null
                        : 'Judul Catatan tidak boleh kosong',
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Divider(
                      color: Colors.black,
                      height: 10,
                      thickness: 0.5,
                    ),
                  ),
                ),
                TextField(
                  maxLines: 10,
                  controller: _contentcontroller,
                  style: Theme.of(context).textTheme.bodyText1,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                    fillColor: Colors.black,
                    border: const OutlineInputBorder(),
                    labelText: 'Isi Catatan',
                    errorText: contentValidate
                        ? null
                        : 'Isi Catatan tidak boleh kosong',
                  ),
                ),
                const Expanded(
                  child: SizedBox(
                    height: 10,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      saveNote();
                    },
                    child: Text(
                      'Simpan',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showAlert(context) {}
}
