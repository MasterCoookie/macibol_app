import 'package:flutter/material.dart';
import 'package:macibol/models/shopping_list.dart';
import 'package:macibol/screens/home/shoppingListTile.dart';
import 'package:provider/provider.dart';

class ShoppingLists extends StatefulWidget {

  @override
  _ShoppingListsState createState() => _ShoppingListsState();
}

class _ShoppingListsState extends State<ShoppingLists> {
  @override
  Widget build(BuildContext context) {

    final shoppingLists = Provider.of<List<ShoppingList>>(context) ?? [];

    if(shoppingLists != null) {
      shoppingLists.forEach((element) {
        print(element.title);
        print(element.aisles);
      });
    }

    return ListView.builder(
      itemCount: shoppingLists.length,
      itemBuilder: (context, index) {
        return ShoppingListTile(list: shoppingLists[index]);
      },
    );
  }
}