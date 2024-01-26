import 'package:e_pedidos_front/models/order_model.dart';
import 'package:e_pedidos_front/shared/widgets/custom_table/table_green.dart';
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
                      Color container = const Color.fromRGBO(100, 255, 106, 1);
                      Color text = const Color.fromRGBO(23, 160, 53, 1);
                      String svg = 'lib/assets/table_green.svg';

                      if (widget.list[index].actualStatus == 'CLOSED') {
                        return Container();
                      }

                      if (widget.list[index].actualStatus == 'NEWORDER') {
                        setState(() {
                          svg = 'lib/assets/table_yellow.svg';
                          container = const Color.fromRGBO(255, 250, 118, 1);
                          text = const Color.fromRGBO(219, 184, 0, 1);
                        });
                      } else if (widget.list[index].actualStatus == 'PENDING') {
                        setState(() {
                          svg = 'lib/assets/table_red.svg';
                          container = const Color.fromRGBO(255, 85, 85, 1);
                          text = const Color.fromRGBO(154, 0, 0, 1);
                        });
                      }
                      return TableCard(
                        order: widget.list[index],
                        containerColor: container,
                        textColor: text,
                        svg: svg
                      ); 
                    },
                  ),
                ),
              ],
            ),
          );
  }
}