import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditContact extends StatefulWidget {
  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  Map data = {};
  bool _init = false;
  var _first = "";
  var _last = "";
  var _phone = "";
  var _email = "";

  @override
  void initState() {
    super.initState();
    // print(context);
    // parseData();
  }

  void parseData() {
    if (!_init && data.isNotEmpty) {
      setState(() {
        _first = data['contact']['first'];
        _last = data['contact']['last'];
        _phone = data['contact']['phone'];
        _email = data['contact']['email'];
        _init = true;
      });
    } else if (data.isEmpty) {}
  }

  @override
  Widget build(BuildContext context) {
    try {
      data = ModalRoute.of(context)!.settings.arguments as Map;
    } catch (e) {
      print("No data passed");
    }
    parseData();
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.fromLTRB(50, 100, 50, 0),
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Icon(
                Icons.account_circle_rounded,
                size: 70,
              )),
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
                        Navigator.pop(context, false);
                      },
                    ),
                  ),
                  ElevatedButton(
                    child: Text('SAVE'),
                    onPressed: () {
                      // print(_first.text);
                      Navigator.pop(context, true);
                    },
                  )
                ],
              ))
        ],
      ),
    ));
  }
}
