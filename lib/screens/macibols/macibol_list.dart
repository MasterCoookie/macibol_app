import 'package:flutter/material.dart';
import 'package:macibol/loading.dart';
import 'package:macibol/models/product.dart';
import 'package:macibol/models/shopping_list.dart';
import 'package:macibol/models/user.dart';
import 'package:macibol/screens/macibols/product_editor.dart';
import 'package:macibol/screens/macibols/product_list.dart';
import 'package:macibol/services/db.dart';
import 'package:provider/provider.dart';

class MacibolList extends StatefulWidget {

  @override
  _MacibolListState createState() => _MacibolListState();
}

class _MacibolListState extends State<MacibolList> {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser>(context);

    void _showProductEditor(ShoppingList shoppingList, int index) {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
        child: ProductEditor(shoppingList: shoppingList, index: index),
      );
    });
  }

    final shoppingList = Provider.of<List<ShoppingList>>(context) ?? null;
    if(shoppingList == null) {
      return Loading();
    }

    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        // padding: EdgeInsets.all(8),
        itemCount: shoppingList[0].aisles.length,
        itemBuilder: (BuildContext context, int index) {
          dynamic products = DBService(uid: user.uid).getProductsByAisle(shoppingList[0].documentId, shoppingList[0].aisles[index]);
          return Column(
            children: [
              Card(
                
                margin: EdgeInsets.fromLTRB(1, 6, 1, 1),
                child: ListTile(
                  onLongPress: () async {
                    await DBService(uid: user.uid).deleteAisleProducts(shoppingList[0].documentId, shoppingList[0].aisles[index]);
                    shoppingList[0].aisles.removeAt(index);
                    await DBService(uid: user.uid).updateListData(shoppingList[0].title, shoppingList[0].done, shoppingList[0].aisles);
                  },
                  title: Text(shoppingList[0].aisles[index], style: TextStyle(fontSize: 18),),
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.green[400],
                    child: Text((index + 1).toString()),
                    
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_upward_rounded),
                        onPressed: () {
                          // print(shoppingList[0].aisles);
                          if (index > 0) {
                            shoppingList[0].aisles.insert(index - 1, shoppingList[0].aisles.removeAt(index));
                            DBService(uid: user.uid).updateListData(shoppingList[0].title, shoppingList[0].done, shoppingList[0].aisles);
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_downward_rounded),
                        onPressed: () {
                          if (index < shoppingList[0].aisles.length - 1) {
                            shoppingList[0].aisles.insert(index + 1, shoppingList[0].aisles.removeAt(index));
                            DBService(uid: user.uid).updateListData(shoppingList[0].title, shoppingList[0].done, shoppingList[0].aisles);
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          _showProductEditor(shoppingList[0], index);
                        },
                      )
                    ],
                  ),
                ),
                
              ),
              Container(
                child: StreamProvider<List<Product>>.value(
                  initialData: [],
                  value: products,
                  child: ProductList(),
                ),
              )
            ],
          );
        }, // single aisle generator ends
      )
    );
  }
}