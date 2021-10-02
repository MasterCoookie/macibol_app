import 'package:flutter/material.dart';
import 'package:macibol/constants.dart';
import 'package:macibol/loading.dart';
import 'package:macibol/models/template.dart';
import 'package:macibol/models/user.dart';
import 'package:macibol/services/db.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListCreator extends StatefulWidget {


  @override
  _ListCreatorState createState() => _ListCreatorState();
}

class _ListCreatorState extends State<ListCreator> {

  List<Template> getTemplates(CustomUser user) {
    
    
  }

  String listName;

  final _formKey = GlobalKey<FormState>();

  String templateId = "Brak";
  List aisles;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser>(context);
    var templateCollection = FirebaseFirestore.instance.collection('templates').where('ownerUid', isEqualTo: user.uid);
    

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
              Text('Templatka', style: TextStyle(fontSize: 18)),
              SizedBox(height: 20,),
              FutureBuilder<QuerySnapshot>(
                  future: templateCollection.get(),
                  builder: (BuildContext context, var snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                        var docs = snapshot.data.docs;
                        var docsList = docs.map((doc) {
                          return DropdownMenuItem(
                            value: doc.id,
                            child: Text(doc.get('name')),
                            onTap: () => { aisles = doc.get('aisles') },
                          );
                        }).toList();
                        docsList.insert(0, DropdownMenuItem(
                          value: "Brak",
                          child: Text("Brak"),
                        ));
                        return DropdownButtonFormField(
                          value: templateId,
                          items: docsList,
                          onChanged: (val) => setState(() => templateId = val),
                      );
                    }
                    return Loading();
                  }
                ),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green[300])),
                child: Text('Stwórz', style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  if(_formKey.currentState.validate()) {
                    await DBService(uid: user.uid).updateListData(listName, false, templateId == "Brak" ? <dynamic>[] : aisles);
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