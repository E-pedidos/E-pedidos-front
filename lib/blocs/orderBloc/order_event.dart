import 'package:e_pedidos_front/models/order_model.dart';

abstract class OrderEvent {}

class GetOrders extends OrderEvent{}

class NewOrderAddedEvent extends OrderEvent {
  final OrderModel newOrder;

  NewOrderAddedEvent(this.newOrder);
}


class UpdateOrderEvent extends OrderEvent {
  final OrderModel updatedOrder;

  UpdateOrderEvent(this.updatedOrder);
}