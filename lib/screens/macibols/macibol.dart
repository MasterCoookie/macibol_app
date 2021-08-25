import 'package:flutter/material.dart';
import 'package:macibol/models/shopping_list.dart';


class Macibol extends StatefulWidget {

  @override
  _MacibolState createState() => _MacibolState();
}

class _MacibolState extends State<Macibol> {

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context).settings.arguments as ShoppingList;

    return Scaffold(
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
      body: Container(),
    );
  }
}