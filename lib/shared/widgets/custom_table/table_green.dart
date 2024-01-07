import 'package:e_pedidos_front/models/order_model.dart';
import 'package:e_pedidos_front/pages/order_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TableCard extends StatelessWidget {
  final OrderModel order;
  const TableCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 72,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(100, 255, 106, 1), 
      ),
      child: GestureDetector(
        onTap: (){
           Navigator.push(context,
          MaterialPageRoute(builder: (context) => OrderDetailPage( order: order)));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'lib/assets/table_green.svg',
              width: 32,
              height: 27,
            ),
            const SizedBox(height: 5),
            Text(
              order.tableNumber.toString(),
              style: const TextStyle(
                  color: Color.fromRGBO(23, 160, 53, 1),
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
