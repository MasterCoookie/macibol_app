import 'package:flutter/material.dart';
import 'package:macibol/screens/authenticate/authenticate.dart';
import 'package:macibol/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:macibol/models/user.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser>(context);

    if(user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}