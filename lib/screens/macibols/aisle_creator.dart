import 'package:flutter/material.dart';
import 'package:macibol/constants.dart';
import 'package:macibol/models/shopping_list.dart';
import 'package:provider/provider.dart';
import 'package:macibol/models/user.dart';
import 'package:macibol/services/db.dart';

class AisleCreator extends StatefulWidget {

  final ShoppingList shoppingList;
  AisleCreator({ this.shoppingList });

  @override
  _AisleCreatorState createState() => _AisleCreatorState();
}

class _AisleCreatorState extends State<AisleCreator> {

  String aisleName;
  bool bottom = true;
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser>(context);

    return SingleChildScrollView(
      child: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text("Stwórz Alejkę", style: TextStyle(fontSize: 18),),
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecor.copyWith(hintText: "Nazwa"),
                validator: (val) => val.isEmpty ? "Podaj nazwę" : null,
                onChanged: (val) => aisleName = val,
              ), SizedBox(height: 18,),
              IconButton(
                icon: Icon(bottom ? Icons.arrow_upward : Icons.arrow_downward),
                onPressed: () {
                  setState(() {
                    bottom = !bottom;                
                  });
                } ,
              ), SizedBox(height: 20,),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green[300])),
                child: Text('Stwórz', style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    widget.shoppingList.aisles.insert(bottom ? widget.shoppingList.aisles.length : 0 ,aisleName);
                    print(aisleName);
                    await DBService(uid: user.uid).updateListData(widget.shoppingList.title, widget.shoppingList.done, widget.shoppingList.aisles);
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