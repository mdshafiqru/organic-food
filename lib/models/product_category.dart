class ProductCategory {
  String? id;
  String? name;

  ProductCategory({this.id, this.name});

  ProductCategory.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
  }
}
