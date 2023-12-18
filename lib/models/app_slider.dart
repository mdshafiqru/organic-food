class AppSlider {
  String? image;

  AppSlider({this.image});

  AppSlider.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }
}
