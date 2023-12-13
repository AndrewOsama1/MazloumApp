class BrandModel {
  List<Brands>? brands;

  BrandModel({this.brands});

  BrandModel.fromJson(Map<String, dynamic> json) {
    if (json['brands'] != null) {
      brands = <Brands>[];
      json['brands'].forEach((v) {
        brands!.add(new Brands.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.brands != null) {
      data['brands'] = this.brands!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Brands {
  int? id;
  int? mazloumId;
  String? name;
  String? brandNameEN;
  String? brandDetails;
  bool? isActive;
  String? slug;
  String? image;
  String? createdAt;

  Brands(
      {this.id,
        this.mazloumId,
        this.name,
        this.brandNameEN,
        this.brandDetails,
        this.isActive,
        this.slug,
        this.image,
        this.createdAt});

  Brands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mazloumId = json['mazloumId'];
    name = json['name'];
    brandNameEN = json['brandNameEN'];
    brandDetails = json['brandDetails'];
    isActive = json['isActive'];
    slug = json['slug'];
    image = json['image'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mazloumId'] = this.mazloumId;
    data['name'] = this.name;
    data['brandNameEN'] = this.brandNameEN;
    data['brandDetails'] = this.brandDetails;
    data['isActive'] = this.isActive;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
