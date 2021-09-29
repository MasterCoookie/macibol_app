class Product {

  final String name;
  final double price;
  final bool promo;
  final bool checked;
  final double quantity;
  final String assocShoppingListId;
  final String aisle;
  String prodId;

  Product({ this.name, this.price, this.promo, this.checked, this.quantity, this.assocShoppingListId, this.aisle }) : prodId = '$assocShoppingListId-$name';
}