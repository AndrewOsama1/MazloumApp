class UserModel {
  int? id;
  String? email;
  String? phone;
  String? firstName;
  String? lastName;
  String? cache;

  int? walletValue;

  UserModel(
      {this.id,
        this.email,
        this.phone,
        this.firstName,
        this.lastName,
        this.cache,

        this.walletValue});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    walletValue = json['walletValue'];
    cache = json['cache'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['phone'] = phone;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['walletValue'] = walletValue;
    data['cache'] = cache;
    return data;
  }
}
