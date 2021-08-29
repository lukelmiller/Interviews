import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Contacts extends StatefulWidget {
  Contacts({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List _contacts = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/contacts.json');
    final data = await json.decode(response);
    setState(() {
      _contacts = data["contacts"];
    });
  }

  Future<void> deleteContact(int index) async {
    print("deleting: " + index.toString());
    setState(() {
      _contacts.removeAt(index);
    });
    final outer = json.encode(_contacts);
    final out = "{'contacts':" + outer + "}";
    // NEED to write out to json to persist data
    // print(out);
  }

  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        toolbarHeight: 35,
        // backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _contacts.length > 0
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _contacts.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(5),
                          child: ListTile(
                              leading: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.account_circle,
                                    ),
                                  ]),
                              title: Text(_contacts[index]["first"] +
                                  " " +
                                  _contacts[index]["last"]),
                              subtitle: Text(_contacts[index]["phone"]),
                              onTap: () {
                                print(_contacts[index]["first"] + " tapped");
                              },
                              trailing: PopupMenuButton(
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(
                                      child: InkWell(
                                        child: Text("Edit"),
                                        onTap: () {
                                          print("edit");
                                          Navigator.pushNamed(
                                              context, '/edit_contact',
                                              arguments: {
                                                'contact': _contacts[index]
                                              });
                                        },
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: InkWell(
                                          child: Text("Delete"),
                                          onTap: () => showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    title: Text("Delete " +
                                                        _contacts[index]
                                                            ["first"] +
                                                        " " +
                                                        _contacts[index]
                                                            ["last"]),
                                                    actions: <Widget>[
                                                      TextButton(
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: const Text(
                                                              'Cancel')),
                                                      TextButton(
                                                          onPressed: () => {
                                                                deleteContact(
                                                                    index),
                                                                Navigator.pop(
                                                                    context)
                                                              },
                                                          child: const Text(
                                                              'Delete')),
                                                    ],
                                                  ))),
                                    )
                                  ];
                                },
                              )),
                        );
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/edit_contact');
        },
        tooltip: 'Add Contact',
        child: Icon(Icons.add),
      ),
    );
  }
}
