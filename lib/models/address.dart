import 'division.dart';

class Address {
  String? id;
  String? district;
  String? thana;
  String? location;
  Division? division;

  Address({
    this.id,
    this.division,
    this.district,
    this.thana,
    this.location,
  });

  Address.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    division = json['division'] != null ? Division.fromJson(json['division']) : null;
    district = json['district'];
    thana = json['thana'];
    location = json['location'];
  }
}
