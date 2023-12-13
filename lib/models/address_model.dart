class AddressModel {
  int? id;
  String? deliveryName;
  String? firstLine;
  String? area;
  String? city;
  String? postCode;
  String? createdAt;
  String? updatedAt;
  int? userId;

  AddressModel(
      {this.id,
        this.deliveryName,
        this.firstLine,
        this.area,
        this.city,
        this.postCode,
        this.createdAt,
        this.updatedAt,
        this.userId});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    deliveryName = json['deliveryName'];
    firstLine = json['firstLine'];
    area = json['area'];
    city = json['city'];
    postCode = json['postCode'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['deliveryName'] = this.deliveryName;
    data['firstLine'] = this.firstLine;
    data['area'] = this.area;
    data['city'] = this.city;
    data['postCode'] = this.postCode;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['userId'] = this.userId;
    return data;
  }
}
