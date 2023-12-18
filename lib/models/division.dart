class Division {
  String? id;
  String? name;
  double? deliveryCharge;

  Division({this.id, this.name, this.deliveryCharge});

  Division.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    deliveryCharge = json['deliveryCharge'] != null ? double.parse(json['deliveryCharge'].toString()) : null;
  }
}
