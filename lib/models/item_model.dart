class ItemModel {
  String? id;
  String? name;
  String? description;
  bool? isTrending;
  String? image;
  String? filialId;
  String? fcateId;
  String? valor;
  String? productCost;
  String? ownerId;
  String? createdAt;
  String? updatedAt;
  String? photoUrl;

  ItemModel(
      {this.id,
      this.name,
      this.description,
      this.isTrending,
      this.image,
      this.filialId,
      this.fcateId,
      this.valor,
      this.productCost,
      this.ownerId,
      this.createdAt,
      this.updatedAt,
      this.photoUrl});

  ItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isTrending = json['isTrending'];
    image = json['image'];
    filialId = json['filialId'];
    fcateId = json['fcateId'];
    valor = json['valor'];
    productCost = json['product_cost'];
    ownerId = json['ownerId'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photoUrl = json['photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['isTrending'] = isTrending;
    data['image'] = image;
    data['filialId'] = filialId;
    data['fcateId'] = fcateId;
    data['valor'] = valor;
    data['product_cost'] = productCost;
    data['ownerId'] = ownerId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['photo_url'] = photoUrl;
    return data;
  }
}
