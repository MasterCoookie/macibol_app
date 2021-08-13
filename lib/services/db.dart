import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {

  final String uid;
  DBService({ this.uid });

  final CollectionReference listCollection = FirebaseFirestore.instance.collection('shopping_lists');
  final CollectionReference productCollection = FirebaseFirestore.instance.collection('products');

  Future updateListData(String title, bool done, List aisles) async {
    return await listCollection.doc('$uid-$title').set({
      'title': title,
      'done' : done,
      'aisles': aisles,
      'ownerUid': uid
    });
  }
}