import 'package:flutter/material.dart';

class CustomCardProductSales extends StatefulWidget {
  const CustomCardProductSales({
    super.key,
  });

  @override
  State<CustomCardProductSales> createState() => _CustomCardProductSalesState();
}

class _CustomCardProductSalesState extends State<CustomCardProductSales> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromRGBO(43, 184, 49, 1),
          width: 2.0,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 9),
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(43, 184, 49, 1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Produto mais pedido',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
            child: Column(
              children: [],
            ),
          )
        ],
      ),
    );
  }
}
