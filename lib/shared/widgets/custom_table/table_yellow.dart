import 'package:e_pedidos_front/models/order_model.dart';
import 'package:e_pedidos_front/pages/order_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TableYellow extends StatelessWidget {
  final OrderModel order;
  const TableYellow({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrderDetailPage(order: order)));
      },
      child: Container(
        width: 72,
        height: 72,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(255, 250, 118, 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'lib/assets/table_yellow.svg',
              width: 32,
              height: 27,
            ),
            const SizedBox(height: 5),
            Text(
              order.tableNumber.toString(),
              style: const TextStyle(
                  color: Color.fromRGBO(219, 184, 0, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
