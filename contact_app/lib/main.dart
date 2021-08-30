import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:contact_app/pages/contacts.dart';
import 'package:contact_app/pages/edit_contact.dart';
import 'package:contact_app/pages/view_contact.dart';

void main() => runApp(MaterialApp(
      title: 'Contacts',
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,

      // FOR TESTING:
      // initialRoute: '/view_contact',

      //Main Routes:
      routes: {
        '/': (context) => Contacts(title: 'Contacts'),
        '/edit_contact': (context) => EditContact(),
        '/view_contact': (context) => ViewContact(),
      },
    ));
