import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Contacts extends StatefulWidget {
  Contacts({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
                                        },
                                      ),
                                    ),
                                    PopupMenuItem(
                                      child: InkWell(
                                        child: Text("Delete"),
                                        onTap: () {
                                          print("delete");
                                          deleteContact(index);
                                        },
                                      ),
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
        onPressed: () {},
        tooltip: 'Add Contact',
        child: Icon(Icons.add),
      ),
    );
  }
}
