import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:macibol/models/shopping_list.dart';
import 'package:macibol/services/db.dart';
import 'package:macibol/models/user.dart';
import 'package:provider/provider.dart';

class ListEditor extends StatefulWidget {

  final ShoppingList shoppingList;
  ListEditor({ this.shoppingList });

  @override
  _ListEditorState createState() => _ListEditorState();
}

class _ListEditorState extends State<ListEditor> {

  bool checkboxVal;
  bool initCheckboxVal = true;
  

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
              Text('Modyfikuj Listę', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20,),
              CheckboxListTile(
                title: Text('Zrobiona?'),
                // self made initial value
                value: initCheckboxVal ? widget.shoppingList.done : checkboxVal,
                onChanged: (val) async {
                  setState(() {
                    initCheckboxVal = false;
                    checkboxVal = val;                  
                  });
                  if(_formKey.currentState.validate()) {
                    await db.updateListData(widget.shoppingList.title, checkboxVal, widget.shoppingList.aisles);
                  }
                  Navigator.pop(context);
                },
              ),SizedBox(height: 20,),
              TextButton.icon(
                icon: Icon(Icons.download_sharp),
                label: Text('Wyeksportuj Templatkę Sklepu'),
                onPressed: () async {
                  await db.updateTemplateData((widget.shoppingList.title + " - Template"), widget.shoppingList.aisles, null);
                  Fluttertoast.showToast(
                    msg: 'Wyeksportowano pomyślnie',
                    toastLength: Toast.LENGTH_SHORT,
                    backgroundColor: Colors.green[400],
                    textColor: Colors.white,
                    fontSize: 16
                  );
                  Navigator.pop(context);
                },
              ),SizedBox(height: 20,),
              TextButton.icon(
                icon: Icon(Icons.delete),
                label: Text('Usuń (Przytrzymaj)'),
                onLongPress: () async {
                  await db.deleteShoppingList(widget.shoppingList.title);
                  Navigator.pop(context);
                },
                onPressed: () {},
              ),SizedBox(height: 20,),
            ],
          ),
        ),
      ),
    );
  }
}