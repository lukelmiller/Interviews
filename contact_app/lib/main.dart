import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:contact_app/pages/contacts.dart';
import 'package:contact_app/pages/edit_contact.dart';

void main() => runApp(MaterialApp(
  title: 'Contacts',
  theme: ThemeData(
    brightness: Brightness.light,
  ),
  darkTheme: ThemeData(
    brightness: Brightness.dark,
  ),
  debugShowCheckedModeBanner: false,
  initialRoute: '/edit_contact',
  routes: {
    '/' : (context) => Contacts(title: 'Contacts'),
    '/edit_contact' : (context) => EditContact(),
  },

));

