import 'package:flutter/material.dart';

class Register extends StatefulWidget {

  final Function toggleViewFun;
  Register({ this.toggleViewFun });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Text('Register');
  }
}