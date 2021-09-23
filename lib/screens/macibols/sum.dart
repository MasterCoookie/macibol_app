import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:macibol/models/shopping_list.dart';

class MacibolSum extends StatefulWidget {

  final ShoppingList shoppingList;
  MacibolSum({ this.shoppingList });

  @override
  _MacibolSumState createState() => _MacibolSumState();
}

class _MacibolSumState extends State<MacibolSum> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('products')
              .where("assocShoppingListId", isEqualTo: widget.shoppingList.documentId).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(snapshot.hasError) {
          return Text('Err');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }

        double sum = 0;
        snapshot.data.docs.forEach((doc) {
          sum += (doc.get('price') ?? 0) * (doc.get('quantity') ?? 0);
        });
        return Text("Przewidywana suma $sum", style: TextStyle(fontSize: 20),);

      },
    );
  }
}