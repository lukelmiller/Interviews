import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Main Contacts Page
// Description: List view of all contacts pulled from json file.
// Click to view, click "..." to access edit and delete functionality

class Contacts extends StatefulWidget {
  Contacts({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List _contacts = [];

  //Reads in JSON File of contacts
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/contacts.json');
    final data = await json.decode(response);
    setState(() {
      _contacts = data["contacts"];
    });
  }

  //Inits data pulling from JSON
  @override
  void initState() {
    super.initState();
    readJson();
  }

  //Function handles navigation to 'view_contact' page and data i/o
  void _navigateView(BuildContext context, Object contact, int index) async {
    final result = await Navigator.pushNamed(context, '/view_contact',
        arguments: {'contact': contact}) as Map;
    if (result.isNotEmpty) {
      if (result["delete"]) {
        deleteContact(index);
      } else {
        setState(() {
          _contacts[index]["first"] = result["first"];
          _contacts[index]["last"] = result["last"];
          _contacts[index]["phone"] = result["phone"];
          _contacts[index]["email"] = result["email"];
          //TODO: For data persistance write out to json file after contact edit
        });
      }
    }
  }

  //Function handles navigation to prefilled 'edit_contact' page and data i/o
  void _navigateEdit(BuildContext context, Object contact, int index) async {
    final result = await Navigator.pushNamed(context, '/edit_contact',
        arguments: {'contact': contact}) as Map;
    if (result.isNotEmpty) {
      setState(() {
        _contacts[index]["first"] = result["first"];
        _contacts[index]["last"] = result["last"];
        _contacts[index]["phone"] = result["phone"];
        _contacts[index]["email"] = result["email"];
        //TODO: For data persistance write out to json file after contact edit
      });
    }
  }

  //Function handles navigation to empty 'edit_contact' page and data i/o
  void _navigateAdd(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/edit_contact') as Map;
    if (result.isNotEmpty) {
      setState(() {
        _contacts.add({
          'first': result["first"],
          'last': result["last"],
          'phone': result["phone"],
          'email': result["email"]
          //TODO: For data persistance write out to json file after contact add
        });
      });
    }
  }

  //Delete's contact in map
  //TODO: For data persistance write out to json file after deletion
  Future<void> deleteContact(int index) async {
    setState(() {
      _contacts.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Top Bar
      appBar: AppBar(
        title: Text(widget.title),
        toolbarHeight: 35,
        shadowColor: Colors.transparent,
      ),
      // List of contacts
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _contacts.length > 0
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _contacts.length,
                      itemBuilder: (context, index) {
                        // Actual contact card
                        // TODO: Split off Card into separate widget
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
                                _navigateView(context, _contacts[index], index);
                              },
                              trailing: PopupMenuButton(
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(
                                      child: InkWell(
                                        child: Text("Edit"),
                                        onTap: () {
                                          _navigateEdit(
                                              context, _contacts[index], index);
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
      // Add Contact Floating Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateAdd(context);
        },
        tooltip: 'Add Contact',
        child: Icon(Icons.add),
      ),
    );
  }
}
