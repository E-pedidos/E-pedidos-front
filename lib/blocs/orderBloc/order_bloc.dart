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
  List<OrderModel> orders = [];


  OrderBloc(): super(OrderInitialState()){
    initSocket(); 
    on(_mapEventToState);
  }

  void initSocket() {
    presf.getIdFilial().then((filial) {
      _socket = io('ws://epedidosapp.info:8000/',
          <String, dynamic>{
          'transports': ['websocket'],
        });

      _socket.connect();

      _socket.onConnect((data) { 
        print('conectei $data'); 
      });
      

      _socket.emitWithAck('enter-filial', filial, ack: (data){
        print('filial $data');
      });

      _socket.on("new-order-added", (data){
        print(data);
        orders.add(data);
      });
      
      _socket.onConnectError((err) => print('Erro de conexão: $err'));
      _socket.onError((err) => print('Erro: $err'));
    });
  }


  void _mapEventToState(OrderEvent event, Emitter emit) async{
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