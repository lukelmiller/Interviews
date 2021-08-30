import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Edit (& Add) Contacts Page
// Description: Edit a contact's attributes or add a contact then allow for
// saving changes or cancelling

class EditContact extends StatefulWidget {
  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  //Local Variables hold contact info as well as init passed data
  Map data = {};
  bool _init = false;
  var _first = "";
  var _last = "";
  var _phone = "";
  var _email = "";

  //Recieves passed in data and pre-fills all know info for contact
  void parseData() {
    if (!_init && data.isNotEmpty) {
      setState(() {
        _first = data['contact']['first'];
        _last = data['contact']['last'];
        _phone = data['contact']['phone'];
        _email = data['contact']['email'];
        _init = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //grabs data from context (previous page) if there is any
    try {
      data = ModalRoute.of(context)!.settings.arguments as Map;
      parseData();
    } catch (error) {
      // For Testing:
      // print("No data passed");
    }

    return Scaffold(
        body: Container(
      margin: const EdgeInsets.fromLTRB(50, 100, 50, 0),
      child: Column(
        // Contact Form
        children: [
          //Profile Icon
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Icon(
                Icons.account_circle_rounded,
                size: 70,
              )),

          //First Name Attribute
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: TextField(
                controller: new TextEditingController.fromValue(
                    new TextEditingValue(
                        text: _first,
                        selection: new TextSelection.collapsed(
                            offset: _first.length))),
                onChanged: (String val) {
                  setState(() {
                    _first = val;
                  });
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'John',
                  labelText: 'First Name',
                ),
              )),

          //Last Name attribute
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: TextField(
                controller: new TextEditingController.fromValue(
                    new TextEditingValue(
                        text: _last,
                        selection:
                            new TextSelection.collapsed(offset: _last.length))),
                onChanged: (String val) {
                  setState(() {
                    _last = val;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Doe',
                    labelText: 'Last Name'),
              )),

          //Phone Number Attribute
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: TextField(
                controller: new TextEditingController.fromValue(
                    new TextEditingValue(
                        text: _phone,
                        selection: new TextSelection.collapsed(
                            offset: _phone.length))),
                onChanged: (String val) {
                  setState(() {
                    _phone = val;
                  });
                },
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '1234567890',
                    labelText: 'Phone Number'),
              )),

          //Email Attribute
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: TextField(
                controller: new TextEditingController.fromValue(
                    new TextEditingValue(
                        text: _email,
                        selection: new TextSelection.collapsed(
                            offset: _email.length))),
                onChanged: (String val) {
                  setState(() {
                    _email = val;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'jdoe@email.com',
                    labelText: 'Email'),
              )),

          // Save & Cancel Buttons
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 55, 0),
                    child: TextButton(
                      child: Text('CANCEL'),
                      onPressed: () {
                        Navigator.pop(context, {});
                      },
                    ),
                  ),
                  ElevatedButton(
                    child: Text('SAVE'),
                    onPressed: () {
                      //Check if any attributes are empty
                      if (_first != "" &&
                          _last != "" &&
                          _phone != "" &&
                          _email != "") {
                        Navigator.pop(context, {
                          'first': _first,
                          'last': _last,
                          'phone': _phone,
                          'email': _email
                        });
                      }
                      //Error In Saving Info Dialog
                      else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: Text("Could Not Save"),
                                  content: Text(
                                      "One or more fields are empty, please fill out all information for contact."),
                                  actions: <Widget>[
                                    TextButton(
                                        child: const Text('OK'),
                                        onPressed: () => Navigator.pop(context))
                                  ],
                                ));
                      }
                    },
                  )
                ],
              ))
        ],
      ),
    ));
  }
}
