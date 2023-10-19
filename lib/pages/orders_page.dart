import 'package:e_pedidos_front/shared/widgets/custom_card_orders.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return CustomLayout(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(31, 25, 31, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pedidos', 
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),), 
            const Text(
              'Histórico de pedidos',
              style: TextStyle(
                fontSize: 13,
                color: Color.fromRGBO(61, 61, 61, 1),
                fontWeight: FontWeight.w500
                )
              ),
              const SizedBox(
                height: 17,
              ),
              Expanded(
                child: ListView(
                  children: const [
                     CardOrders(
                      text: 'Maria - Mesa 06 - Clique para ver', 
                      svgPath: 'lib/assets/touch_icon.svg'
                      ),
                      CardOrders(
                      text: 'André - Mesa 01 - Clique para ver', 
                      svgPath: 'lib/assets/touch_icon.svg'
                      ),
                      CardOrders(
                      text: 'Lúcia - Mesa 11 - Clique para ver', 
                      svgPath: 'lib/assets/touch_icon.svg'
                      ),
                      CardOrders(
                      text: 'Paulo - Mesa 05 - Clique para ver', 
                      svgPath: 'lib/assets/touch_icon.svg'
                      ),
                      CardOrders(
                      text: 'Ana - Mesa 09 - Clique para ver', 
                      svgPath: 'lib/assets/touch_icon.svg'
                      ),
                      CardOrders(
                      text: 'Ian - Mesa 22 - Clique para ver', 
                      svgPath: 'lib/assets/touch_icon.svg'
                      ),
                      CardOrders(
                      text: 'Carlos - Mesa 03 - Clique para ver', 
                      svgPath: 'lib/assets/touch_icon.svg'
                      ),
                      CardOrders(
                      text: 'Pedro - Mesa 29 - Clique para ver', 
                      svgPath: 'lib/assets/touch_icon.svg'
                      ),
                  ],
                ))
            ],
        ),
      ),
    ));
  }
}
