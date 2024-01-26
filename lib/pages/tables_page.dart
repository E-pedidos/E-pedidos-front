import 'package:e_pedidos_front/blocs/orderBloc/order_bloc.dart';
import 'package:e_pedidos_front/blocs/orderBloc/order_event.dart';
import 'package:e_pedidos_front/blocs/orderBloc/order_state.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shared/widgets/custom_table/table_green.dart';


class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage> {
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
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 21),
                        child: Text(
                          'Mesas',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  color: const Color.fromRGBO(54, 148, 178, 1),
                                  width: 2.0)),
                          child: ListView(
                            children: [
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: List.generate(
                                  orders.length,
                                  (index) {
                                    Color container = const Color.fromRGBO(100, 255, 106, 1);
                                    Color text = const Color.fromRGBO(23, 160, 53, 1);
                                    String svg = 'lib/assets/table_green.svg';

                                    if (orders[index].actualStatus == 'CLOSED') {
                                      return Container();
                                    }

                                    if (orders[index].actualStatus == 'NEWORDER') {
                                      setState(() {
                                        svg = 'lib/assets/table_yellow.svg';
                                        container = const Color.fromRGBO(255, 250, 118, 1);
                                        text = const Color.fromRGBO(219, 184, 0, 1);
                                      });
                                    } else if (orders[index].actualStatus == 'PENDING') {
                                      setState(() {
                                        svg = 'lib/assets/table_red.svg';
                                        container = const Color.fromRGBO(255, 85, 85, 1);
                                        text = const Color.fromRGBO(154, 0, 0, 1);
                                      });
                                    }
                                    return TableCard(
                                      order: orders[index],
                                      containerColor:container,
                                      textColor: text,  
                                      svg: svg,
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
              ),
            ));
          }
          return const SizedBox();
        });
  }
}
