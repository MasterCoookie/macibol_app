import 'package:flutter/material.dart';
import 'package:macibol/constants.dart';
import 'package:macibol/services/auth.dart';

class Register extends StatefulWidget {

  final Function toggleViewFun;
  Register({ this.toggleViewFun });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final _formKey = GlobalKey<FormState>();

  final AuthService _auth = AuthService();

  String email;
  String password;

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
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecor.copyWith(hintText: 'email'),
                keyboardType: TextInputType.emailAddress,
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecor.copyWith(hintText: 'password'),
                validator: (val) => (val.length < 8) ? 'Enter valid password' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecor.copyWith(hintText: 'repeat password'),
                validator: (val) => (val != password) ? 'Passwords don\'t match' : null,
                obscureText: true,
                onChanged: (val) {}
              ),
              ElevatedButton(
                child: Text('Register', style: TextStyle(color: Colors.black)),
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    dynamic result = await _auth.registerWithEmailPwd(email, password);
                    if(result == null) {
                      print('err');
                    }
                  }
                },
              )
            ],
          ),
        ),
      )
    );
  }
}