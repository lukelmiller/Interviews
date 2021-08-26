import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditContact extends StatefulWidget{
  @override 
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact>{
  String _first = "";
  String _last = "";
  String _phone = "";
  String _email = "";



  @override 
  Widget build(BuildContext context){
    return Scaffold(
      body: Text('Contact'),
    );
  }
}