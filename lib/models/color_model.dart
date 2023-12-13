class ColorModel {
  List<ColorsData>? colors;

  ColorModel({this.colors});

  ColorModel.fromJson(Map<String, dynamic> json) {
    if (json['colors'] != null) {
      colors = <ColorsData>[];
      json['colors'].forEach((v) {
        colors!.add(new ColorsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.colors != null) {
      data['colors'] = this.colors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ColorsData {
  int? id;
  String? name;
  String? slug;

  ColorsData({this.id, this.name, this.slug});

  ColorsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    return data;
  }
}
