import 'dart:ffi';

class Product {

  final String name;
  final Float price;
  final bool promo;
  final bool checked;
  final int quantity;

  Product({ this.name, this.price, this.promo, this.checked, this.quantity });
}