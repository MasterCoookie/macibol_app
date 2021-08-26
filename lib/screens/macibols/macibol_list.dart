import 'package:flutter/material.dart';
import 'package:macibol/models/shopping_list.dart';
import 'package:provider/provider.dart';

class MacibolList extends StatefulWidget {

  @override
  _MacibolListState createState() => _MacibolListState();
}

class _MacibolListState extends State<MacibolList> {
  @override
  Widget build(BuildContext context) {

    final shoppingList = Provider.of<List<ShoppingList>>(context) ?? null;
    print(shoppingList[0].title);

    return Container(
      child: Text("XD", style: TextStyle(color: Colors.black),),
    );
  }
}