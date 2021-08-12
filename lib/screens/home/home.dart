import 'package:flutter/material.dart';
import 'package:macibol/services/auth.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0,
        title: Text('Zakupki czekają', style: TextStyle(color: Colors.black)),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.exit_to_app, color: Colors.black),
            label: Text('Log Out', style: TextStyle(color: Colors.black)),
            onPressed: () async { _auth.logOut(); },
          )
        ],
      ),
    );
  }
}