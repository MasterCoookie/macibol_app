import 'package:flutter/material.dart';
import 'package:macibol/screens/authenticate/login.dart';
import 'package:macibol/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showLogin = true;
  void toggleView() {
    print(showLogin);
    setState(() => showLogin = !showLogin);
  }

  @override
  Widget build(BuildContext context) {
    if(showLogin) {
      return Container(child: Login(toggleViewFun: toggleView));
    } else {
      return Container(child: Register(toggleViewFun: toggleView));
    }
  }
}