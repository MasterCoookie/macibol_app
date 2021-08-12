import 'package:flutter/material.dart';
import 'package:macibol/models/user.dart';
import 'package:macibol/screens/wrapper.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:macibol/services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),  
    );
  }
}
