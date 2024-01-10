import 'package:e_pedidos_front/models/order_item_model.dart';
import 'package:e_pedidos_front/shared/widgets/custom_card_order_detail.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';

class UpdateOrderDetailPage extends StatefulWidget {
  final List<OrderItemsModel> order;

  const UpdateOrderDetailPage({super.key, required this.order});

  @override
  State<UpdateOrderDetailPage> createState() => _UpdateOrderDetailPageState();
}

class _UpdateOrderDetailPageState extends State<UpdateOrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return CustomLayout(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(31, 25, 31, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('NOVOS ITENS',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Expanded(
              child: ListView.builder(
                itemCount: widget.order.length,
                itemBuilder: (context, index) {
                  return CardOrderDetail(
                    nameItem: widget.order[index].name!,
                    quantity:widget.order[index].quantity!.toString(),
                    value: widget.order[index].valor!,
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