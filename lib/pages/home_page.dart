import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';
import 'package:e_pedidos_front/shared/widgets/custom_card_table.dart';

import 'package:e_pedidos_front/shared/widgets/custom_card_orders.dart';


class HomePag extends StatefulWidget {
  const HomePag({super.key});

  @override
  State<HomePag> createState() => _HomePagState();
}

class _HomePagState extends State<HomePag> {
  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(31, 25, 31, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CardTables(),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Pedidos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 13,
              ),
              Expanded(
                  child: ListView(
                children: const [
                  CardOrders(
                    text: 'André - Mesa 01 - Sanduíche de espinafre',
                    svgPath: 'lib/assets/icons_orders/icon_green.svg',
                  ),
                  CardOrders(
                    text: 'André - Mesa 01 - Sanduíche de espinafre',
                    svgPath: 'lib/assets/icons_orders/icon_red.svg',
                  ),
                  CardOrders(
                    text: 'André - Mesa 01 - Sanduíche de espinafre',
                    svgPath: 'lib/assets/icons_orders/icon_yellow.svg',
                  ),
                  CardOrders(
                    text: 'André - Mesa 01 - Sanduíche de espinafre',
                    svgPath: 'lib/assets/icons_orders/icon_green.svg',
                  ),
                  CardOrders(
                    text: 'André - Mesa 01 - Sanduíche de espinafre',
                    svgPath: 'lib/assets/icons_orders/icon_yellow.svg',
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
