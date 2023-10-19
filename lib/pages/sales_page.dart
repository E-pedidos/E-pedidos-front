import 'package:e_pedidos_front/shared/widgets/custom_card_sales.dart';
import 'package:e_pedidos_front/shared/widgets/custom_card_sales_product.dart';
import 'package:e_pedidos_front/shared/widgets/custom_card_sales_product_red.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
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
              'Vendas',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const Text('Acompanhe suas vendas',
                style: TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(61, 61, 61, 1),
                    fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 26,
            ),
            Expanded(
                child: ListView(
              children: const [
                CustomCardSales(
                    title: 'Vendas do dia',
                    products: ' 54',
                    orders: ' 22',
                    mediumValue: ' 20,99',
                    totalValue: ' 1.100'),
                SizedBox(
                  height: 24,
                ),
                CustomCardSales(
                    title: 'Vendas do mês',
                    products: ' 2300',
                    orders: ' 122',
                    mediumValue: ' 18,99',
                    totalValue: ' 11.100'),
                SizedBox(
                  height: 24,
                ),
                CustomCardProductSales(),
                SizedBox(
                  height: 24,
                ),
                CustomCardProductSalesRed()
              ],
            ))
          ],
        ),
      ),
    ));
  }
}
