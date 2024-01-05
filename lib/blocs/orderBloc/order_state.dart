
import 'package:e_pedidos_front/models/order_model.dart';

abstract class OrderState {
  final List<OrderModel> orders;
  final int? statusCode;

  OrderState({required this.orders,  this.statusCode});
} 

class OrderInitialState extends OrderState {
  OrderInitialState(): super(orders: []);
}

class OrderLoadingState extends OrderState {
  OrderLoadingState(): super(orders: []);
}

class OrderLoadedState extends OrderState {
  OrderLoadedState({required List<OrderModel> orders}): super(orders: orders);
}

class OrderErrorState extends OrderState {
  final Exception exception;
  OrderErrorState({ required this.exception}) : super(orders: []);
}