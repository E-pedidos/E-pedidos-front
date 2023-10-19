import 'package:flutter/material.dart';

class CustomCardSales extends StatefulWidget {
  final String title;
  final String products;
  final String orders;
  final String mediumValue;
  final String totalValue;

  const CustomCardSales({
    super.key, 
    required this.title, 
    required this.orders, 
    required this.mediumValue, 
    required this.totalValue, 
    required this.products
    });

  @override
  State<CustomCardSales> createState() => _CustomCardSalesState();
}

class _CustomCardSalesState extends State<CustomCardSales> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromRGBO(54, 148, 178, 1),
          width: 2.0,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 9),
            width: double.infinity,
            decoration: const BoxDecoration(
                border: Border(
              bottom: BorderSide(
                  color: Color.fromRGBO(54, 148, 178, 1), width: 2.0),
            )),
            child: const Text(
              'Vendas do Dia',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Produtos consumidos:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                    Text( widget.products, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                  ],
                ),
                const SizedBox(height: 8,),
                Row(
                  children: [
                    const Text('Total de pedidos:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                    Text(widget.orders, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                  ],
                ),
                const SizedBox(height: 8,),
                Row(
                  children: [
                    const Text('Média valor:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                    Text(widget.mediumValue, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                  ],
                ),
                const SizedBox(height: 8,),
                Row(
                  children: [
                    const Text('Total vendido:', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
                    Text(widget.totalValue, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
                  ],
                ),
              ],
            ),
            )
        ],
      ),
    );
  }
}
