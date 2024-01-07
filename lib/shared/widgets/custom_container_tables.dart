import 'package:e_pedidos_front/models/order_model.dart';
import 'package:e_pedidos_front/shared/widgets/custom_table/table_green.dart';
import 'package:e_pedidos_front/shared/widgets/custom_table/table_red.dart';
import 'package:e_pedidos_front/shared/widgets/custom_table/table_yellow.dart';
import 'package:flutter/material.dart';

class ConatainerTable extends StatefulWidget {
  final List<OrderModel> list;
  const ConatainerTable({super.key, required this.list});

  @override
  State<ConatainerTable> createState() => _ConatainerTableState();
}

class _ConatainerTableState extends State<ConatainerTable> {
  @override
  Widget build(BuildContext context) {
    return widget.list.isEmpty
        ? const Expanded(
            child: Center(
              child: Text("Não há mesas online!"),
            ),
          )
        : Expanded(
            child: ListView(
              children: [
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List.generate(
                    widget.list.length,
                    (index) {
                      if (widget.list[index].actualStatus == 'open') {
                        return TableCard(order: widget.list[index]);
                      } else if (widget.list[index].actualStatus ==
                          'newOrder') {
                        return TableYellow(order: widget.list[index]);
                      } else if (widget.list[index].actualStatus ==
                          'Close') {
                        return TableRed(order: widget.list[index]);
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
