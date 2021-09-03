import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:macibol/models/product.dart';


class ProductList extends StatefulWidget {

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {

    final productList = Provider.of<List<Product>>(context) ?? [];
    print(productList.length);

    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      itemCount: productList.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(productList[index].name),
          ),
        );
      },
    );
  }
}