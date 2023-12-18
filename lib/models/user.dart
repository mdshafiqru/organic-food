class User {
  String? id;
  String? name;
  String? phone;
  String? token;

  User({this.id, this.name, this.phone, this.token});

  User.fromJson(Map<String, dynamic> json) {
    final user = json['user'];

    id = user['_id'];
    name = user['name'];
    phone = user['phone'];

    token = json['token'];
  }
}
