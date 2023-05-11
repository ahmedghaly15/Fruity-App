class UserModel {
  String? email;
  String? username;
  String? uId;
  String? phone;
  String? address;

  UserModel({
    this.email,
    this.phone,
    this.uId,
    this.address,
    this.username,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    address = json['address'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'phone': phone,
      'uId': uId,
      'address': address,
    };
  }
}
