import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_notes_app/models/note.dart';
import 'package:flutter_notes_app/pages/create_note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Note> myProducts = <Note>[];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getNote(),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0x22c6e2ff),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: myProducts.isEmpty
                ? Center(
                    child: Text('Catatan Kosong',
                        style: Theme.of(context).textTheme.headline5),
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemCount: myProducts.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: () {
                          editItem(myProducts[index].id);
                        },
                        onLongPress: () {
                          deleteNote(index);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                myProducts[index].title,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    myProducts[index].content.length > 75
                                        ? myProducts[index]
                                                .content
                                                .substring(0, 75) +
                                            "..."
                                        : myProducts[index].content,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    DateTime.fromMicrosecondsSinceEpoch(
                                            int.parse(
                                                myProducts[index].createdAt))
                                        .toString()
                                        .substring(0, 10),
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addItemToList();
            // showSnackBar(context);
          },
          tooltip: 'Tambah Catatan',
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void addItemToList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return const CreateNote("");
      }),
    ).then((value) => setState(() {}));
  }

  void editItem(id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return CreateNote(id);
      }),
    ).then((value) => setState(() {}));
  }

  void saveNote() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('notes')) {
      prefs.clear();
    }

    prefs.setString('notes', json.encode(myProducts));
  }

  Future<void> getNote() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('notes')) {
      final myNote = json.decode(prefs.getString('notes') ?? "");
      List<Note> temp =
          (myNote as List).map((item) => Note.fromJson(item)).toList();
      myProducts = temp;
    }
  }

  void showSnackBar(context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Catatan berhasil ditambahkan",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void deleteNote(index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Yakin untuk menghapus catatan ini ? "),
        actions: <Widget>[
          ElevatedButton(
            child: const Text(
              'Hapus',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              myProducts.removeAt(index);
              saveNote();
              setState(() {});
              Navigator.of(context).pop();
            },
          ),
          OutlinedButton(
            child: const Text('Batal'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
