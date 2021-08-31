import 'package:flutter/material.dart';
import 'package:macibol/loading.dart';
import 'package:macibol/models/product.dart';
import 'package:macibol/models/shopping_list.dart';
import 'package:macibol/screens/macibols/product_editor.dart';
import 'package:provider/provider.dart';

class MacibolList extends StatefulWidget {

  @override
  _MacibolListState createState() => _MacibolListState();
}

class _MacibolListState extends State<MacibolList> {
  @override
  Widget build(BuildContext context) {

    void _showProductEditor(ShoppingList shoppingList) {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
        child: ProductEditor(shoppingList: shoppingList),
      );
    });
  }

    final shoppingList = Provider.of<List<ShoppingList>>(context) ?? null;
    if(shoppingList == null) {
      return Loading();
    }

    return Container(
      child: ListView.builder(
        // padding: EdgeInsets.all(8),
        itemCount: shoppingList[0].aisles.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Card(
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.green[400],
                    child: Text((index + 1).toString()),
                    
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          _showProductEditor(shoppingList[0]);
                        },
                      )
                    ],
                  ),
                ),
                
              ),
              // TODO - product lister
            ],
          );
        },
      )
    );
  }
}