import 'package:flutter/material.dart';

// View Contacts Page
// Description: View a contact's attributes with options to edit/delete contact.
// This is an easier visual to view contact information

class ViewContact extends StatefulWidget {
  @override
  _ViewContactState createState() => _ViewContactState();
}

class _ViewContactState extends State<ViewContact> {
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

  //Function handles navigation to prefilled 'edit_contact' page and data i/o
  void _navigateEdit(BuildContext context) async {
    final result =
        await Navigator.pushNamed(context, '/edit_contact', arguments: {
      'contact': {
        'first': _first,
        'last': _last,
        'phone': _phone,
        'email': _email
      }
    }) as Map;
    if (result.isNotEmpty) {
      setState(() {
        _first = result["first"];
        _last = result["last"];
        _phone = result["phone"];
        _email = result["email"];
      });
    }
  }

  //Sends flag to previous view to delete contact from map
  void deleteContact(BuildContext context) {
    Navigator.pop(context, {'delete': true});
  }

  @override
  Widget build(BuildContext context) {
    try {
      data = ModalRoute.of(context)!.settings.arguments as Map;
      parseData();
    } catch (error) {
      // For Testing:
      // print("No data passed");
    }

    return Scaffold(
        body: Container(
      margin: const EdgeInsets.symmetric(vertical: 70, horizontal: 40),
      child: Column(
        children: [
          //Back Button & Edit Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_rounded, size: 50),
                onPressed: () {
                  Navigator.pop(context, {
                    'first': _first,
                    'last': _last,
                    'phone': _phone,
                    'email': _email,
                    'delete': false
                  });
                },
              ),
              ElevatedButton(
                child: Text('EDIT'),
                onPressed: () {
                  _navigateEdit(context);
                },
              )
            ],
          ),

          //First Name & Last Name with Icon
          Container(
            margin: const EdgeInsets.only(top: 150),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.account_circle_rounded,
                    size: 30,
                  ),
                ),
                Text(
                  _first + " " + _last,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          //Phone Number with Icon
          Container(
            margin: const EdgeInsets.only(top: 75),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.phone,
                    size: 30,
                  ),
                ),
                Text(
                  _phone,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          //Email with Icon
          Container(
            margin: const EdgeInsets.only(top: 75),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.mail,
                    size: 30,
                  ),
                ),
                Text(
                  _email,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          //Delete Button
          Container(
            margin: const EdgeInsets.only(top: 200),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                    child: Text('DELETE'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red)),
                    onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text("Delete " + _first + " " + _last),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel')),
                                TextButton(
                                    onPressed: () => {
                                          Navigator.pop(context),
                                          deleteContact(context)
                                        },
                                    child: const Text('Delete')),
                              ],
                            )))
              ],
            ),
          )
        ],
      ),
    ));
  }
}
