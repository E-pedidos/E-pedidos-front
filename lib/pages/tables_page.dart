import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:e_pedidos_front/shared/widgets/custom_table/table_green.dart';
import 'package:e_pedidos_front/shared/widgets/custom_table/table_red.dart';
import 'package:e_pedidos_front/shared/widgets/custom_table/table_yellow.dart';
import 'package:flutter/material.dart';

class TablePage extends StatefulWidget {
  const TablePage({super.key});

  @override
  State<TablePage> createState() => _TablePageState();
}

class _TablePageState extends State<TablePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                  ),),
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
                      children: const [
                        Wrap(
                          spacing: 5.0,
                          runSpacing: 5.0,
                          children: [
                            TableGreen(),
                            TableRed(),
                            TableYellow(),
                            TableGreen(),
                            TableRed(),
                            TableYellow(),
                            TableGreen(),
                            TableRed(),
                            TableYellow(),
                            TableGreen(),
                            TableRed(),
                          ],
                        )
                      ],
                    ),
                  ),
              )
            ]),
        ),
      ) 
    );
  }
}