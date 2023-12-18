class AppInfo {
  String? id;
  String? about;
  String? terms;
  String? privacy;
  String? email;

  AppInfo({this.id, this.about, this.terms, this.privacy, this.email});

  AppInfo.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    about = json['about'];
    terms = json['terms'];
    privacy = json['privacy'];
    email = json['email'];
  }
}
