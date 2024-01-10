import 'package:e_pedidos_front/models/order_model.dart';
import 'package:e_pedidos_front/pages/update_order_detail_page%20.dart';
import 'package:e_pedidos_front/shared/widgets/custom_button.dart';
import 'package:e_pedidos_front/shared/widgets/custom_card_order_detail.dart';
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
              'Nome do cliente: ${widget.order.clientName}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text('Status da Comanda: ${widget.order.actualStatus}',
                style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(61, 61, 61, 1),
                    fontWeight: FontWeight.w600)),
            Text('Valor total do pedido: ${widget.order.totalValor}',
                style: const TextStyle(
                    fontSize: 17,
                    color: Color.fromRGBO(61, 61, 61, 1),
                    fontWeight: FontWeight.w600)),
            Text('observação: ${widget.order.observation}',
                style: const TextStyle(
                    fontSize: 17,
                    color: Color.fromRGBO(61, 61, 61, 1),
                    fontWeight: FontWeight.w600)),
            widget.order.updatedOrderItems!.isNotEmpty
                ? CustomButton(
                    text: 'Ver novos items',
                    backgroundColor: const Color.fromRGBO(54, 148, 178, 1),
                    onPressed: () {
                     Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UpdateOrderDetailPage(order: widget.order.updatedOrderItems!)));
                    })
                : const SizedBox(),
            const Divider(
              color: Color.fromRGBO(54, 148, 178, 1),
            ),
            const Text('ITENS TOTAIS DA COMANDA',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Expanded(
              child: ListView.builder(
                itemCount: widget.order.orderItems!.length,
                itemBuilder: (context, index) {
                  return CardOrderDetail(
                    nameItem: widget.order.orderItems![index].name!,
                    quantity:
                        widget.order.orderItems![index].quantity!.toString(),
                    value: widget.order.orderItems![index].valor!,
                  );
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}