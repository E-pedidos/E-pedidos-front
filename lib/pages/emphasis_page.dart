import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';

class EmphasisPage extends StatefulWidget {
  const EmphasisPage({super.key});

  @override
  State<EmphasisPage> createState() => _EmphasisPageState();
}

class _EmphasisPageState extends State<EmphasisPage> {
  @override
  Widget build(BuildContext context) {
    return CustomLayout(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(31, 25, 10, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Destaques',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const Text('Altere os seus destaques',
                style: TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(61, 61, 61, 1),
                    fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 17,
            ),
            Expanded(
              child: ListView(
              children: [
                Wrap(
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: double.tryParse('165'),
                      height: double.tryParse('129'),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: const Color.fromRGBO(54, 148, 178, 1),
                              width: 2.0)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: double.tryParse('165'),
                      height: double.tryParse('177'),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('lib/assets/card.png'),
                          const SizedBox(height: 7,),
                          const Text('Salada grega', style: TextStyle(fontWeight: FontWeight.w500),),
                          const Text('R\$ 14,99', style: TextStyle(fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: double.tryParse('165'),
                      height: double.tryParse('177'),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('lib/assets/card.png'),
                          const SizedBox(height: 7,),
                          const Text('Salada grega', style: TextStyle(fontWeight: FontWeight.w500),),
                          const Text('R\$ 14,99', style: TextStyle(fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                  ),

                ]), 
              ],
            ))
          ],
        ),
      ),
    ));
  }
}
