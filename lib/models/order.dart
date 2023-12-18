import 'address.dart';
import 'order_item.dart';

class Order {
  String? id;
  String? userId;
  String? invoiceId;
  Address? address;
  String? phone;
  String? receiverName;
  double? orderAmount;
  double? deliveryCharge;
  double? grandTotal;
  String? status;
  String? reason;
  String? createdAt;
  String? updatedAt;
  List<OrderItem>? orderItems;

  Order({
    this.id,
    this.userId,
    this.invoiceId,
    this.address,
    this.phone,
    this.receiverName,
    this.orderAmount,
    this.deliveryCharge,
    this.grandTotal,
    this.status,
    this.reason,
    this.createdAt,
    this.updatedAt,
    this.orderItems,
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['userId'];
    invoiceId = json['invoiceId'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    phone = json['phone'];
    receiverName = json['receiverName'];
    orderAmount = json['orderAmount'] != null ? double.parse(json['orderAmount'].toString()) : null;
    deliveryCharge = json['deliveryCharge'] != null ? double.parse(json['deliveryCharge'].toString()) : null;
    grandTotal = json['grandTotal'] != null ? double.parse(json['grandTotal'].toString()) : null;
    status = json['status'];
    reason = json['reason'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];

    if (json['orderItems'] != null) {
      orderItems = <OrderItem>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(OrderItem.fromJson(v));
      });
    }
  }
}
