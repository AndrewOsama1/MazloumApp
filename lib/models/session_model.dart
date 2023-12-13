class SessionModel {
  int? orderId;
  String? sessionId;
  String? merchant;
  String? apiVersion;
  String? status;

  SessionModel({this.orderId, this.sessionId, this.merchant, this.apiVersion, this.status});

  SessionModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    sessionId = json['sessionId'];
    merchant = json['merchant'];
    apiVersion = json['apiVersion'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderId'] = this.orderId;
    data['sessionId'] = this.sessionId;
      data['merchant'] = this.merchant!;
    data['apiVersion'] = this.apiVersion;
    data['status'] = this.status;
    return data;
  }
}
