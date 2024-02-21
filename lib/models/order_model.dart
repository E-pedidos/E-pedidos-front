import 'package:e_pedidos_front/models/order_item_model.dart';

class OrderModel {
  String? id;
  String? clientName;
  int? tableNumber;
  String? observation;
  String? address;
  String? actualStatus;
  String? totalValor;
  String? createdAt;
  String? updatedAt;
  List<OrderItemsModel>? orderItems;
  List<OrderItemsModel>? updatedOrderItems;

  OrderModel(
      {this.id,
      this.clientName,
      this.tableNumber,
      this.observation,
      this.address,
      this.actualStatus,
      this.totalValor,
      this.createdAt,
      this.updatedAt,
      this.orderItems,
      this.updatedOrderItems});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientName = json['client_name'];
    tableNumber = json['table_number'];
    observation = json['observation'];
    address = json['address'];
    actualStatus = json['actual_status'];
    totalValor = json['total_valor'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['orderItems'] != null) {
      orderItems = <OrderItemsModel>[];
      json['orderItems'].forEach((v) {
        orderItems!.add(OrderItemsModel.fromJson(v));
      });
    }
    if (json['updatedOrderItems'] != null) {
      updatedOrderItems = <OrderItemsModel>[];
      json['updatedOrderItems'].forEach((v) {
        updatedOrderItems!.add(OrderItemsModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['client_name'] = clientName;
    data['table_number'] = tableNumber;
    data['observation'] = observation;
    data['address'] = address;
    data['actual_status'] = actualStatus;
    data['total_valor'] = totalValor;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (orderItems != null) {
      data['orderItems'] = orderItems!.map((v) => v.toJson()).toList();
    }
    if (updatedOrderItems != null) {
      data['updatedOrderItems'] =
          updatedOrderItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'OrderModel{id: $id, clientName: $clientName, tableNumber: $tableNumber, observation: $observation, address: $address, actualStatus: $actualStatus, totalValor: $totalValor, createdAt: $createdAt, updatedAt: $updatedAt, orderItems: $orderItems, updatedOrderItems: $updatedOrderItems}';
  }
}
