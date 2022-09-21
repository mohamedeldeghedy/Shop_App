class UserModel {
  bool? status;
  late Data data;

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }
}

class Data {
  int? id;
  late String name;
  late String email;
  late String phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
