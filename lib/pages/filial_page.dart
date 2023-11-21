import 'package:e_pedidos_front/shared/widgets/custom_button.dart';
import 'package:e_pedidos_front/shared/widgets/custom_icon_button.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilialPage extends StatefulWidget {
  const FilialPage({super.key});

  @override
  State<FilialPage> createState() => _FilialPageState();
}

class _FilialPageState extends State<FilialPage> {
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
              'Filiais',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 37,
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 19),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(54, 148, 178, 1),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Filial Teste',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: [
                              CustomIconButton(
                                  icon: Icons.remove,
                                  backgroundColor:
                                      const Color.fromRGBO(255, 148, 148, 1),
                                  iconColor: const Color.fromRGBO(255, 0, 0, 1),
                                  onTap: () {}),
                              const SizedBox(
                                width: 4,
                              ),
                              CustomIconButton(
                                  icon: Icons.edit,
                                  backgroundColor:
                                      const Color.fromRGBO(54, 148, 178, 1),
                                  iconColor: Colors.white,
                                  onTap: () {}),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: CustomButton(
                  text: 'Editar',
                  textColor: const Color.fromRGBO(150, 108, 0, 1),
                  backgroundColor: const Color.fromRGBO(255, 223, 107, 1),
                  onPressed: () {}),
            )
          ],
        ),
      ),
    ));
  }
}
