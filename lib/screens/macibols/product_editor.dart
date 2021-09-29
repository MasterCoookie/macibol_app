import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  double quantity;

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser>(context);
    final db = DBService(uid: user.uid);

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
                      onChanged: (val) {
                        val = val.replaceAll(',', '.');
                        price = double.parse(val);
                      },
                    ),
                  ), SizedBox(width: 20,),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: textInputDecor.copyWith(hintText: "Ilość"),
                      onChanged: (val){
                        val = val.replaceAll(',', '.');
                        quantity = double.parse(val);
                      },
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
                    if(await db.findExistingProudcts(widget.shoppingList, productName)) {
                      Fluttertoast.showToast(
                        msg: 'Taki produkt już istnieje',
                        toastLength: Toast.LENGTH_SHORT,
                        backgroundColor: Colors.green[400],
                        textColor: Colors.white,
                        fontSize: 16
                      );
                    } else {
                      await db.updateProductData(productName, price, promo, false, quantity, '${widget.shoppingList.ownerUid}-${widget.shoppingList.title}', widget.shoppingList.aisles[widget.index]);
                      Navigator.pop(context);
                    }
                  }
                  
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}