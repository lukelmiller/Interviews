import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditContact extends StatefulWidget {
  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  var _first = TextEditingController();
  var _last = TextEditingController();
  var _phone = TextEditingController();
  var _email = TextEditingController();

  @override
  void initState() {
    super.initState();
    parseData();
  }

  void parseData() {
    setState(() {
      _first.text = "luke";
      _last.text = "miller";
      _phone.text = "1234567890";
      _email.text = "lmiller@gmail.com";
    });
  }

  @override
  Widget build(BuildContext context) {
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
                controller: _first,
                onChanged: (String val) {
                  setState(() {
                    _first.text = val;
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
                controller: _last,
                onChanged: (String val) {
                  setState(() {
                    _last.text = val;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Doe',
                    labelText: 'Last Name'),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: TextField(
                controller: _phone,
                onChanged: (String val) {
                  setState(() {
                    _phone.text = val;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: '1234567890',
                    labelText: 'Phone Number'),
              )),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: TextField(
                controller: _email,
                onChanged: (String val) {
                  setState(() {
                    _email.text = val;
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
                      onPressed: () {},
                    ),
                  ),
                  ElevatedButton(
                    child: Text('SAVE'),
                    onPressed: () {
                      print(_first.text);
                    },
                  )
                ],
              ))
        ],
      ),
    ));
  }
}
