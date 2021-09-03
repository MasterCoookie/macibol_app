import 'package:flutter/material.dart';
import 'package:macibol/constants.dart';
import 'package:macibol/models/shopping_list.dart';
import 'package:macibol/models/user.dart';
import 'package:provider/provider.dart';
import 'package:macibol/services/db.dart';

class ProductEditor extends StatefulWidget {
  final ShoppingList shoppingList;
  final int index;
  ProductEditor({ this.shoppingList, this.index });

  @override
  _ProductEditorState createState() => _ProductEditorState();
}

class _ProductEditorState extends State<ProductEditor> {

  String productName;
  double price;
  bool promo = false;
  int quantity;

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    // print(widget.shoppingList.aisles[widget.index]);
    final user = Provider.of<CustomUser>(context);

    return SingleChildScrollView(
      child: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text("Dodaj produkt", style: TextStyle(fontSize: 18)), SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecor.copyWith(hintText: "Nazwa"),
                validator: (val) => val.isEmpty ? "Podaj nazwę" : null,
                onChanged: (val) => productName = val,
              ), SizedBox(height: 24,),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: textInputDecor.copyWith(hintText: "Cena"),
                      onChanged: (val) => price = double.parse(val),
                    ),
                  ), SizedBox(width: 20,),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: textInputDecor.copyWith(hintText: "Ilość"),
                      onChanged: (val) => quantity = int.parse(val),
                    ),
                  ),
                ],
              ), SizedBox(height: 18,),
              CheckboxListTile(
                title: Text('Promka?'),
                // self made initial value
                value: promo,
                onChanged: (val) async {
                  setState(() {
                    promo = val;                  
                  });                  
                },
              ), SizedBox(height: 18),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green[300])),
                child: Text('Dodaj', style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    await DBService(uid: user.uid).updateProductData(productName, price, promo, false, quantity, '${widget.shoppingList.ownerUid}-${widget.shoppingList.title}', widget.shoppingList.aisles[widget.index]);
                  }
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}