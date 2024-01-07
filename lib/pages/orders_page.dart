import 'package:e_pedidos_front/blocs/orderBloc/order_bloc.dart';
import 'package:e_pedidos_front/blocs/orderBloc/order_event.dart';
import 'package:e_pedidos_front/blocs/orderBloc/order_state.dart';
import 'package:e_pedidos_front/pages/order_detail_page.dart';
import 'package:e_pedidos_front/shared/widgets/custom_card_orders.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late final OrderBloc _orderBloc;

  @override
  void initState() {
    super.initState();
    _orderBloc = OrderBloc();
    _orderBloc.add(GetOrders());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
        bloc: _orderBloc,
        builder: (context, state) {
          final orders = state.orders;
          if (state is OrderLoadingState) {
            return const CustomLayout(
              child: Scaffold(
                body: Padding(
                  padding: EdgeInsets.fromLTRB(31, 25, 31, 100),
                  child: Center(
                      child: CircularProgressIndicator(
                    color: Colors.orange,
                  )),
                ),
              ),
            );
          }
          if (state is OrderLoadedState) {
            return CustomLayout(
                child: Scaffold(
                    body: Padding(
                        padding: const EdgeInsets.fromLTRB(31, 25, 31, 100),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Pedidos',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            const Text('Histórico de pedidos',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: Color.fromRGBO(61, 61, 61, 1),
                                    fontWeight: FontWeight.w500)),
                            const SizedBox(
                              height: 17,
                            ),
                            orders.isEmpty
                                ? const Expanded(
                                    child: Center(
                                      child: Text("não há nenhum pedido!"),
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                      itemCount: orders.length,
                                      itemBuilder: (context, index) {
                                        return CardOrders(
                                          clientName: orders[index].clientName!,
                                          tableNumber:
                                              orders[index].tableNumber!,
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    OrderDetailPage(
                                                  order: orders[index],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        ))));
          }
          return const SizedBox();
        });
  }
}
