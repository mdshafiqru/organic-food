import 'product.dart';

class OrderItem {
  String? id;
  String? orderId;
  Product? product;
  int? qty;
  double? price;
  double? total;

  OrderItem({this.id, this.orderId, this.product, this.qty, this.price, this.total});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    orderId = json['orderId'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    qty = json['qty'] != null ? int.parse(json['qty'].toString()) : null;
    price = json['price'] != null ? double.parse(json['price'].toString()) : null;
    total = json['total'] != null ? double.parse(json['total'].toString()) : null;
  }
}
