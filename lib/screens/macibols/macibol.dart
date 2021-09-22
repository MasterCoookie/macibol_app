import 'package:flutter/material.dart';
import 'package:macibol/models/shopping_list.dart';
import 'package:macibol/models/user.dart';
import 'package:macibol/screens/macibols/aisle_creator.dart';
import 'package:macibol/screens/macibols/macibol_list.dart';
import 'package:macibol/services/db.dart';
import 'package:provider/provider.dart';


class Macibol extends StatefulWidget {
  

  @override
  _MacibolState createState() => _MacibolState();
}

class _MacibolState extends State<Macibol> {
  

  double listSum = 0;
  bool unlocked = true;


  callback(double newListSum) {
    // setState(() {
      listSum += newListSum.toDouble() ?? 0;
      // print(listSum);
    // });
  }

  void _showAisleCreationPanel(ShoppingList shoppingList) {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
        child: AisleCreator(shoppingList: shoppingList),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    final args = ModalRoute.of(context).settings.arguments as ShoppingList;
    final user = Provider.of<CustomUser>(context);
    final db = DBService(uid: user.uid, title: args.title);
    return StreamProvider<List<ShoppingList>>.value(
      initialData: null,
      value: db.shoppingListByTitle,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(args.title),
          actions: [
            StreamBuilder(
              stream: db.getListSum(args),
              builder: (BuildContext context, AsyncSnapshot<double>snapshot) {
                return Text("Przewidywana suma: ${snapshot.hasData ? snapshot.data : "w8"}",
                 style: TextStyle(fontSize: 18),);
              },
            ),
            
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () { _showAisleCreationPanel(args); },
        ),
        body: MacibolList(listSum: listSum, callback: callback),
      ),
    );
  }
}