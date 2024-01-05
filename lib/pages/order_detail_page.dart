import 'package:e_pedidos_front/models/order_model.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';

class OrderDetailPage extends StatefulWidget {
  final OrderModel order;
  const OrderDetailPage({super.key, required this.order});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(31, 25, 31, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pedido cliente: ${widget.order.clientName}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text('Status da mesa: ${widget.order.actualStatus}',
                style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(61, 61, 61, 1),
                    fontWeight: FontWeight.w500)),
            Text('Valor total: ${widget.order.totalValor}',
                style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(61, 61, 61, 1),
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    ));
  }
}
