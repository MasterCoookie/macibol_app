import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:macibol/models/shopping_list.dart';

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

  List<ShoppingList> _shoppingListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ShoppingList(
        title: doc.get('title'),
        done: doc.get('done'),
        aisles: doc.get('aisles') ?? [],
        ownerUid: doc.get('ownerUid')
      );
    }).toList();
  }

  Stream<List<ShoppingList>> get shoppingLists {
    var userLists = listCollection.where("ownerUid", isEqualTo: uid);
    return userLists.snapshots().map(_shoppingListFromSnapshot);
  }

  Future deleteShoppingList(String title) async {
    return await listCollection.doc('$uid-$title').delete();
  }

}