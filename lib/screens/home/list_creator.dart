import 'package:flutter/material.dart';
import 'package:macibol/constants.dart';
import 'package:macibol/models/user.dart';
import 'package:macibol/services/db.dart';
import 'package:provider/provider.dart';

class ListCreator extends StatefulWidget {

  @override
  _ListCreatorState createState() => _ListCreatorState();
}

class _ListCreatorState extends State<ListCreator> {

  String listName;

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
              Text('Stwórz Listę', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20,),
              TextFormField(
                decoration: textInputDecor.copyWith(hintText: 'Nazwa'),
                validator: (val) => val.isEmpty ? 'Wprowadź Nazwę Listy' : null,
                onChanged: (val) => listName = val,
              ),SizedBox(height: 20,),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green[300])),
                child: Text('Stwórz', style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    await DBService(uid: user.uid).updateListData(listName, false, <dynamic>[]);
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