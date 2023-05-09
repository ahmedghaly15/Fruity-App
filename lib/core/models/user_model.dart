class UserModel {
  String? email;
  String? uId;
  String? phone;
  String? address;

  UserModel({
    this.email,
    this.phone,
    this.uId,
    this.address,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'phone': phone,
      'uId': uId,
      'address': address,
    };
  }
}
