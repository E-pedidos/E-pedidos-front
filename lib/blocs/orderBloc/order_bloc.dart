import 'package:bloc/bloc.dart';
import 'package:e_pedidos_front/blocs/orderBloc/order_event.dart';
import 'package:e_pedidos_front/blocs/orderBloc/order_state.dart';
import 'package:e_pedidos_front/models/order_model.dart';
import 'package:e_pedidos_front/repositorys/order_repository.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState>{
   final orderRepository = OrderRepository();

  OrderBloc(): super(OrderInitialState()){
    on(_mapEventToState);
  }

  void _mapEventToState(OrderEvent event, Emitter emit) async{
    List<OrderModel> orders = [];

    emit(OrderLoadingState());

    if(event is GetOrders){
      orders = await orderRepository.getOrders();
    }

    emit(OrderLoadedState(orders: orders));
  }
}