import 'package:flutter/material.dart';
import 'package:macibol/screens/home/list_editor.dart';
import 'package:macibol/models/shopping_list.dart';

class ShoppingListTile extends StatefulWidget {

  

  final ShoppingList shoppingList;
  ShoppingListTile({ this.shoppingList});

  @override
  _ShoppingListTileState createState() => _ShoppingListTileState();
}

class _ShoppingListTileState extends State<ShoppingListTile> {
  @override
  Widget build(BuildContext context) {

  void showListEditorPanel(ShoppingList list) {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
        child: ListEditor(shoppingList: list),
      );
    });
  }

    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          title: Text(widget.shoppingList.title ?? "Nowa lista", style: widget.shoppingList.done ? TextStyle(decoration: TextDecoration.lineThrough) : null,),
          onTap: () { showListEditorPanel(widget.shoppingList); },
        ),
      ),
    );
  }
}