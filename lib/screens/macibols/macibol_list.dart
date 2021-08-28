import 'package:flutter/material.dart';
import 'package:macibol/loading.dart';
import 'package:macibol/models/shopping_list.dart';
import 'package:provider/provider.dart';
import 'package:macibol/models/aisle.dart';

class MacibolList extends StatefulWidget {

  @override
  _MacibolListState createState() => _MacibolListState();
}

class _MacibolListState extends State<MacibolList> {
  @override
  Widget build(BuildContext context) {

    final shoppingList = Provider.of<ShoppingList>(context) ?? null;
    if(shoppingList == null) {
      return Loading();
    }

    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: shoppingList.aisles.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.green[400],
                child: Text(index.toString()),
              ),
            ),
          );
        },
      )
    );
  }
}