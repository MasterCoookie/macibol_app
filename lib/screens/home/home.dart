import 'package:flutter/material.dart';
import 'package:macibol/screens/home/list_creator.dart';
import 'package:macibol/services/auth.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void _showListCreationPanel() {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
        child: ListCreator(),
      );
    });
  }

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
      body: Container(
        child: Column(
          children: [
            ElevatedButton(
              child: Text('Nowa Lista Zakupowa'),
              onPressed: () => _showListCreationPanel(),
            )
        ],),
      ),
    );
  }
}