import 'package:macibol/models/aisle.dart';

class ShoppingList {

  final String title;
  bool done;
  List aisles;
  final String ownerUid;

  ShoppingList({ this.title, this.done, this.aisles, this.ownerUid });
}