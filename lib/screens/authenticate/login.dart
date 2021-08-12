import 'package:flutter/material.dart';
import 'package:macibol/services/auth.dart';

class Login extends StatefulWidget {

  final Function toggleViewFun;


  
  Login({ this.toggleViewFun });

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        elevation: 0,
        title: Text('Log In'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person, color: Colors.black),
            label: Text('Register', style: TextStyle(color: Colors.black)),
            onPressed: () { widget.toggleViewFun(); },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              child: Text('SignIn', style: TextStyle(color: Colors.black)),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () async {
                // if(_formKey.currentState.validate()) {
                  // TODO - actual sign in
                  dynamic result = await _auth.signInAnon();
                  if(result == null) {
                    print('err');
                  }
                }
              // },
            )
          ],
        ),
      )
    );
  }
}