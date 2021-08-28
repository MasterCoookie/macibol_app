import 'package:flutter/material.dart';
import 'package:macibol/models/shopping_list.dart';
import 'package:macibol/models/user.dart';
import 'package:macibol/screens/macibols/macibol_list.dart';
import 'package:macibol/services/db.dart';
import 'package:provider/provider.dart';


class Macibol extends StatefulWidget {

  @override
  _MacibolState createState() => _MacibolState();
}

class _MacibolState extends State<Macibol> {

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context).settings.arguments as ShoppingList;
    final user = Provider.of<CustomUser>(context);

    return StreamProvider<ShoppingList>.value(
      initialData: null,
      value: DBService(uid: user.uid, title: args.title).shoppingListByTitle,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(args.title),
          actions: [
            // IconButton(icon: Icon(Icons.arrow_back), onPressed: () {})
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        // body: MacibolList(),
      ),
    );
  }
}