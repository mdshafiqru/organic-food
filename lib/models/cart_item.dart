import 'product.dart';

class CartItem {
  String? id;
  Product? product;
  int? qty;

  CartItem({this.id, this.product, this.qty});

  CartItem.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    qty = json['qty'] != null ? int.parse(json['qty'].toString()) : null;
  }
}
