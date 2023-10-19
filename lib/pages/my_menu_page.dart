import 'package:e_pedidos_front/shared/widgets/custom_card_menu.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';

class MyMenuPage extends StatefulWidget {
  const MyMenuPage({super.key});

  @override
  State<MyMenuPage> createState() => _MyMenuPageState();
}

class _MyMenuPageState extends State<MyMenuPage> {
  @override
  Widget build(BuildContext context) {
    return  CustomLayout(
        child: Scaffold(
      body: Padding(
        padding:  const EdgeInsets.fromLTRB(31, 35, 31, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Cardápio', style:  TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
            const SizedBox(height: 20,),
            Expanded(
              child: ListView(
                children: const [
                  CustomCardMenu(),
                  CustomCardMenu(),
                  CustomCardMenu(),
                  CustomCardMenu(),
                  CustomCardMenu(),
                  CustomCardMenu(),
                  CustomCardMenu(),
                  CustomCardMenu(),
                  CustomCardMenu(),
                  CustomCardMenu(),
                  CustomCardMenu(),
                ],
              ),
            )
          ]
          ),
      ),
    ));
  }
}
