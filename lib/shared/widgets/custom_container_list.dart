import 'package:e_pedidos_front/models/order_model.dart';
import 'package:e_pedidos_front/pages/order_detail_page.dart';
import 'package:e_pedidos_front/shared/widgets/custom_card_orders.dart';
import 'package:flutter/material.dart';

class ConatainerList extends StatefulWidget {
  final List<OrderModel> list;
  const ConatainerList(
      {super.key, required this.list});

  @override
  State<ConatainerList> createState() => _ConatainerListState();
}

class _ConatainerListState extends State<ConatainerList> {
  @override
  Widget build(BuildContext context) {
    return widget.list.isEmpty
            ? const Expanded(
                child: Center(
                  child: Text("não há pedidos!"),
                ),
              )
            : Expanded(
                child: ListView.builder(
                  itemCount: widget.list.length,
                  itemBuilder: (context, index) {
                    return CardOrders(
                      clientName: widget.list[index].clientName!,
                      tableNumber: widget.list[index].tableNumber!,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OrderDetailPage(
                                    order: widget.list[index])));
                      },
                    );
                  },
                ),
              );
  }
}
