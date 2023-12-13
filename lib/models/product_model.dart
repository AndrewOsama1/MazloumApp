
import 'dart:convert';

class ProductModel {
  int? id;
  String? mazloumBarcode;
  String? nameEN;
  String? nameAR;
  List<String>? images;
  String? reference;
  double? price;
  double? salePrice;
  int? quantity;
  double? discount;
  int? brandId;
  int? categoryId;
  int? colorId;
  double? numberInUnit;
  double? tilesInUnit;
  bool? isNewArrival;
  bool? isOnSale;
  int? isActive;
  String? slug;
  String? material;
  String? dimensions;
  String? lightSource;
  String? skin;
  String? madeIn;
  String? acidity;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? details;
  String? briefDetails;
  List<SpecsValues>? specsValues;
  int localQuantity = 1;

  ProductModel({this.id, this.mazloumBarcode, this.nameEN, this.nameAR, this.images, this.reference, this.price, this.salePrice, this.quantity, this.discount, this.brandId, this.categoryId, this.colorId, this.numberInUnit, this.tilesInUnit, this.isNewArrival, this.isOnSale, this.isActive, this.slug, this.material, this.dimensions, this.lightSource, this.skin, this.madeIn, this.acidity, this.createdAt, this.updatedAt, this.name, this.details, this.briefDetails, this.specsValues});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mazloumBarcode = json['mazloumBarcode'];
    nameEN = json['nameEN'];
    nameAR = json['nameAR'];
    if (json['images'] != null) {
      try {
        images = <String>[];
        jsonDecode(json['images']).forEach((v) {
          images!.add(v);
        });
      }catch(e) {
        images = json['images'].cast<String>();
      }
    }

    reference = json['reference'];
    price = json['price'] * 1.0;
    salePrice = json['salePrice'] * 1.0;
    quantity = json['quantity'];
    discount = json['discount']* 1.0;
    brandId = json['brandId'];
    categoryId = json['categoryId'];
    colorId = json['colorId'];
   numberInUnit = json['numberInUnit']* 1.0;
    tilesInUnit = json['tilesInUnit']* 1.0;
   isNewArrival = json['isNewArrival'];
   isOnSale = json['isOnSale'];
   isActive = json['isActive'];
   slug = json['slug'];
    material = json['material'];
    dimensions = json['dimensions'];
    lightSource = json['lightSource'];
    skin = json['skin'];
    madeIn = json['madeIn'];
    acidity = json['acidity'];
   createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
   name = json['name'];
   details = json['details'];
    briefDetails = json['briefDetails'];
    if (json['specsValues'] != null) {
      specsValues = <SpecsValues>[];
      json['specsValues'].forEach((v) { specsValues!.add(SpecsValues.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mazloumBarcode'] = mazloumBarcode;
    data['nameEN'] = nameEN;
    data['nameAR'] = nameAR;
    data['images'] = images;
    data['reference'] = reference;
    data['price'] = price;
    data['salePrice'] = salePrice;
    data['quantity'] = quantity;
    data['discount'] = discount;
    data['brandId'] = brandId;
    data['categoryId'] = categoryId;
    data['colorId'] = colorId;
    data['numberInUnit'] = numberInUnit;
    data['tilesInUnit'] = tilesInUnit;
    data['isNewArrival'] = isNewArrival;
    data['isOnSale'] = isOnSale;
    data['isActive'] = isActive;
    data['slug'] = slug;
  /*  data['material'] = this.material;
    data['dimensions'] = this.dimensions;
    data['lightSource'] = this.lightSource;
    data['skin'] = this.skin;*/
    data['madeIn'] = this.madeIn;
    // data['acidity'] = this.acidity;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['name'] = this.name;
    data['details'] = this.details;
    data['briefDetails'] = this.briefDetails;
    if (this.specsValues != null) {
      data['specsValues'] = this.specsValues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SpecsValues {
  Spec? spec;
  Value? value;

  SpecsValues({this.spec, this.value});

  SpecsValues.fromJson(Map<String, dynamic> json) {
    spec = json['spec'] != null ? new Spec.fromJson(json['spec']) : null;
    value = json['value'] != null ? new Value.fromJson(json['value']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.spec != null) {
      data['spec'] = this.spec!.toJson();
    }
    if (this.value != null) {
      data['value'] = this.value!.toJson();
    }
    return data;
  }
}

class Spec {
  String? specNameEN;
  String? specNameAR;

  Spec({this.specNameEN, this.specNameAR});

  Spec.fromJson(Map<String, dynamic> json) {
    specNameEN = json['specNameEN'];
    specNameAR = json['specNameAR'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['specNameEN'] = this.specNameEN;
    data['specNameAR'] = this.specNameAR;
    return data;
  }
}

class Value {
  String? specValueNameEN;
  String? specValueNameAR;
  String? slug;
  Spec? spec;

  Value({this.specValueNameEN, this.specValueNameAR, this.slug, this.spec});

  Value.fromJson(Map<String, dynamic> json) {
    specValueNameEN = json['specValueNameEN'];
    specValueNameAR = json['specValueNameAR'];
    slug = json['slug'];
    spec = json['spec'] != null ? new Spec.fromJson(json['spec']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['specValueNameEN'] = this.specValueNameEN;
    data['specValueNameAR'] = this.specValueNameAR;
    data['slug'] = this.slug;
    if (this.spec != null) {
      data['spec'] = this.spec!.toJson();
    }
    return data;
  }
}
