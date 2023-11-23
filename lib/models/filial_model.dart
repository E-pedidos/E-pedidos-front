class FilialModel {
  String? id;
  String? name;
  String? address;
  bool? openedNow;
  bool? acceptInplace;
  bool? acceptTakeout;
  bool? acceptDelivery;
  String? createdAt;
  String? updatedAt;

  FilialModel(
      {this.id,
      this.name,
      this.address,
      this.openedNow,
      this.acceptInplace,
      this.acceptTakeout,
      this.acceptDelivery,
      this.createdAt,
      this.updatedAt});

  FilialModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    openedNow = json['opened_now'];
    acceptInplace = json['accept_inplace'];
    acceptTakeout = json['accept_takeout'];
    acceptDelivery = json['accept_delivery'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['opened_now'] = openedNow;
    data['accept_inplace'] = acceptInplace;
    data['accept_takeout'] = acceptTakeout;
    data['accept_delivery'] = acceptDelivery;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}