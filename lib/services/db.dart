import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:macibol/models/product.dart';
import 'package:macibol/models/shopping_list.dart';
import 'package:macibol/screens/home/shopping_lists.dart';

class DBService {

  final String uid;
  String title;
  DBService({ this.uid, this.title });

  final CollectionReference listCollection = FirebaseFirestore.instance.collection('shopping_lists');
  final CollectionReference productCollection = FirebaseFirestore.instance.collection('products');

  Future updateListData(String title, bool done, List<dynamic> aisles) async {
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
        aisles: document.get('aisles') ?? <dynamic>[],
        ownerUid: document.get('ownerUid'),
        documentId: document.id
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

  Stream<List<ShoppingList>> get shoppingListByTitle {
    var titleCollection = listCollection.where("title", isEqualTo: title).where("ownerUid", isEqualTo: uid);
    return titleCollection.snapshots().map(_shoppingListFromSnapshot);
  }

  Future deleteShoppingList(String title) async {
    return await listCollection.doc('$uid-$title').delete();
  }

  Future updateProductData(String name, double price, bool promo, bool checked, int quantity, String assocShoppingListId, String aisle) async {
    return await productCollection.doc('$assocShoppingListId-$name').set({
      'name': name,
      'price': price,
      'promo': promo,
      'checked': checked,
      'quantity': quantity,
      'assocShoppingListId': assocShoppingListId,
      'aisle': aisle
    });
  }

  List<Product> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Product(
        name: doc.get('name') ?? "err",
        price: doc.get('price') ?? 0,
        promo: doc.get('promo')  ?? false,
        checked: doc.get('checked') ?? false,
        quantity: doc.get('quantity') ?? 0,
        assocShoppingListId: doc.get('assocShoppingListId') ?? 'err',
        aisle: doc.get('aisle') ?? 'err',
      );
    }).toList();
  }

  dynamic getProductsByAisle(String assocShoppingListId, String aisleName) {
    print(assocShoppingListId);
    return productCollection.where("assocShoppingListId", isEqualTo: assocShoppingListId)
           .where("aisle", isEqualTo: aisleName)
           .snapshots().map(_productListFromSnapshot);
  }

  Future deleteProduct(String prodId) async {
    return await productCollection.doc(prodId).delete();
  }
}