class OrderItemsModel {
  String? id;
  String? name;
  String? valor;
  int? quantity;
  String? createdAt;
  String? updatedAt;

  OrderItemsModel(
      {this.id,
      this.name,
      this.valor,
      this.quantity,
      this.createdAt,
      this.updatedAt});

  OrderItemsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    valor = json['valor'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['valor'] = valor;
    data['quantity'] = quantity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}