import 'package:e_pedidos_front/models/order_model.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Pedido'),
      ),
      body: Center(
        child: Text('Detalhes do Pedido ${widget.order.clientName}: ${widget.order.observation}'),
      ),
    );
  }
}