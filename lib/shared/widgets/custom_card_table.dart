import 'package:flutter/material.dart';
import 'package:e_pedidos_front/shared/widgets/custom_table/table_green.dart';
import 'package:e_pedidos_front/shared/widgets/custom_table/table_red.dart';
import 'package:e_pedidos_front/shared/widgets/custom_table/table_yellow.dart';

class CardTables extends StatefulWidget {
  const CardTables({super.key});

  @override
  State<CardTables> createState() => _CardTablesState();
}

class _CardTablesState extends State<CardTables> {
  @override
  Widget build(BuildContext context) {
    return Container(
                  padding: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: const Color.fromRGBO(54, 148, 178, 1),
                          width: 2.0)),
                  child: ListView(
                    children: const [
                      Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 21),
                          child: Text(
                            'Mesas',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          )),
                      Wrap(
                        spacing: 4.0,
                        runSpacing: 4.0,
                        children: [
                          TableGreen(),
                          TableRed(),
                          TableYellow(),
                          TableGreen(),
                          TableRed(),
                          TableYellow(),
                          TableGreen(),
                          TableRed(),
                          TableYellow()
                        ],
                      )
                    ],
                  ),
                );
  }
}