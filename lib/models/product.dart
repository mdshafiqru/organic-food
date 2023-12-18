class Product {
  String? id;
  String? name;
  String? size;
  String? image;
  String? shortDesc;
  double? price;
  String? longDesc;

  Product({this.id, this.name, this.size, this.image, this.shortDesc, this.price, this.longDesc});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    size = json['size'];
    image = json['image'];
    shortDesc = json['shortDesc'];
    price = json['price'] != null ? double.parse(json['price'].toString()) : null;
    longDesc = json['longDesc'];
  }
}
