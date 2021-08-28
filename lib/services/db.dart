import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:macibol/main.dart';
import 'package:macibol/models/aisle.dart';
import 'package:macibol/models/shopping_list.dart';
import 'package:macibol/screens/home/shopping_lists.dart';

class DBService {

  final String uid;
  String title;
  DBService({ this.uid, this.title });

  final CollectionReference listCollection = FirebaseFirestore.instance.collection('shopping_lists');
  final CollectionReference productCollection = FirebaseFirestore.instance.collection('products');

  Future updateListData(String title, bool done, List<Aisle> aisles) async {
    return await listCollection.doc('$uid-$title').set({
      'title': title,
      'done' : done,
      'aisles': aisles,
      'ownerUid': uid
    });
  }

  ShoppingList _singleListFromDoc(QueryDocumentSnapshot<Object> document) {
    return ShoppingList(
        title: document.get('title'),
        done: document.get('done'),
        aisles: document.get('aisles') ?? [],
        ownerUid: document.get('ownerUid')
      );
  }

  List<ShoppingList> _shoppingListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      // print(doc.get('title'));
      return _singleListFromDoc(doc);
    }).toList();
  }

  Stream<List<ShoppingList>> get shoppingLists {
    var userLists = listCollection.where("ownerUid", isEqualTo: uid);
    return userLists.snapshots().map(_shoppingListFromSnapshot);
  }

  Stream<ShoppingList> get shoppingListByTitle {
    var titleCollection = listCollection.where("title", isEqualTo: title).where("ownerUid", isEqualTo: uid);
    var list;
    titleCollection.snapshots().map((snapshot) {
      snapshot.docs.map((doc) => list = _singleListFromDoc(doc));
    });
    print(list);
    return list;
  }

  Future deleteShoppingList(String title) async {
    return await listCollection.doc('$uid-$title').delete();
  }

}