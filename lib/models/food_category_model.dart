class FoodCategory {
  String? id;
  String? name;
  String? ownerId;
  String? createdAt;
  String? updatedAt;

  FoodCategory(
      {this.id, this.name, this.ownerId, this.createdAt, this.updatedAt});

  FoodCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ownerId = json['ownerId'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['ownerId'] = ownerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
