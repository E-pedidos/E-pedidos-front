import 'package:e_pedidos_front/shared/widgets/custom_avatar.dart';
import 'package:e_pedidos_front/shared/widgets/custom_button.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
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
              'Minha conta',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const Text('Adicione o novo produto do seu cardápio',
                style: TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(61, 61, 61, 1),
                    fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 37,
            ),
            const Center(child: CustomAvatar()),
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  const ListTile(
                    leading: Text('Nome da empresa:'),
                    title: Text('EcoVibe Bistrô'),
                    contentPadding: EdgeInsets.all(0),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 1,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(54, 148, 178, 1)),
                  ),
                  const ListTile(
                    leading: Text('Responsável:'),
                    title: Text('Paulo Farias'),
                    contentPadding: EdgeInsets.all(0),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 1,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(54, 148, 178, 1)),
                  ),
                  const ListTile(
                    leading: Text('E-mail:'),
                    title: Text('ecovibebistro@gmail.com'),
                    contentPadding: EdgeInsets.all(0),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 1,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(54, 148, 178, 1)),
                  ),
                  const ListTile(
                    leading: Text('Celular:'),
                    title: Text('(81)99627-0938'),
                    contentPadding: EdgeInsets.all(0),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 1,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(54, 148, 178, 1)),
                  ),
                  const ListTile(
                    leading: Text('CPF/CNPJ:'),
                    title: Text('0000000000'),
                    contentPadding: EdgeInsets.all(0),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 1,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(54, 148, 178, 1)),
                  ),
                  const SizedBox(height: 35,),
                  SizedBox(
                    height: 50,
                    width: 178,
                    child: CustomButton(
                        text: 'Editar',
                        textColor: const Color.fromRGBO(150, 108, 0, 1),
                        backgroundColor: const Color.fromRGBO(255, 223, 107, 1),
                        onPressed: () {}),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
