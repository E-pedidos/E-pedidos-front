import 'package:bloc/bloc.dart';
import 'package:e_pedidos_front/blocs/orderBloc/order_event.dart';
import 'package:e_pedidos_front/blocs/orderBloc/order_state.dart';
import 'package:e_pedidos_front/models/order_model.dart';
import 'package:e_pedidos_front/repositorys/order_repository.dart';
import 'package:e_pedidos_front/shared/utils/shared_preferences_utils.dart';
import 'package:socket_io_client/socket_io_client.dart';


class OrderBloc extends Bloc<OrderEvent, OrderState>{
  final orderRepository = OrderRepository();
  SharedPreferencesUtils presf = SharedPreferencesUtils();
  late final Socket _socket;

  OrderBloc(): super(OrderInitialState()){
    _socket = io('ws://epedidosapp.info:8000/',
       <String, dynamic>{
      'transports': ['websocket'],
      'upgrade': false
    });

    _socket.connect();

    _socket.onConnect((data) { 
      print(data); 
    });

    _socket.onConnectError((err) => print('Erro de conexão: $err'));
    _socket.onError((err) => print('Erro: $err'));
    /* _socket.emit('enter-filial',(data) {
      print(data);
    }); */

    /* _socket.on('new-order-added', (data) {
      // Adicione lógica para processar o novo pedido, se necessário
      print(data);

      // Após receber um novo pedido, emita o evento GetOrders para atualizar a lista
      add(GetOrders());
    }); */
    on(_mapEventToState);
  }


  void _mapEventToState(OrderEvent event, Emitter emit) async{
    List<OrderModel> orders = [];

    emit(OrderLoadingState());

    if(event is GetOrders){
      var res = await orderRepository.getOrders();

      if(res is List<OrderModel>){
        orders = res;
      } else{
        orders = [];
      } 
    }

    emit(OrderLoadedState(orders: orders));
  }

  @override
  Future<void> close() {
    _socket.disconnect();
    return super.close();
  }
}