import 'package:e_pedidos_front/models/order_model.dart';
import 'package:e_pedidos_front/shared/widgets/custom_table/table_green.dart';
import 'package:flutter/material.dart';

class ConatainerTable extends StatefulWidget {
  final bool isLoading;
  final List<OrderModel> list;
  const ConatainerTable({super.key, required this.isLoading, required this.list});

  @override
  State<ConatainerTable> createState() => _ConatainerTableState();
}

class _ConatainerTableState extends State<ConatainerTable> {
  @override
  Widget build(BuildContext context) {
    return  widget.isLoading
        ? const Expanded(
            child: Center(
                child: CircularProgressIndicator(
              color: Colors.orange,
            )),
          )
        : widget.list.isEmpty
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
                        (index) => const TableGreen(),
                      ),
                    ),
                  ],
                ),
              );
  }
}