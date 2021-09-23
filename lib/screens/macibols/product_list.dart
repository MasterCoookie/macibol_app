import 'package:flutter/material.dart';
import 'package:macibol/services/db.dart';
import 'package:provider/provider.dart';
import 'package:macibol/models/product.dart';
import 'package:macibol/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ProductList extends StatefulWidget {

  @override
  _ProductListState createState() => _ProductListState();
  
}

class _ProductListState extends State<ProductList> {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser>(context);
    final db = DBService(uid: user.uid);

    final productList = Provider.of<List<Product>>(context) ?? [];

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.fromLTRB(8, 2, 1, 1),
          child: ListTile(
            title: Text(productList[index].name, style: productList[index].checked ? TextStyle(decoration: TextDecoration.lineThrough) : null),
            trailing: Text("${productList[index].quantity.toString()} x ${productList[index].price..toStringAsFixed(2)}zł (${(productList[index].price*productList[index].quantity).toStringAsFixed(2)}zł)",
                           style: productList[index].checked ? TextStyle(decoration: TextDecoration.lineThrough) : null),
            onTap: () async {
              await db.updateProductData(productList[index].name, productList[index].price, productList[index].promo, !productList[index].checked, productList[index].quantity, productList[index].assocShoppingListId, productList[index].aisle);
            },
            onLongPress: () async {
              await db.deleteProduct(productList[index].prodId);
              return Fluttertoast.showToast(
                msg: 'Usunięto pomyślnie',
                toastLength: Toast.LENGTH_SHORT,
                backgroundColor: Colors.green[400],
                textColor: Colors.white,
                fontSize: 16
              );
            },
          ),
          
        );
      },
    );
  }
}