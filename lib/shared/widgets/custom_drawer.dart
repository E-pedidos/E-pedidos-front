import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      UserAccountsDrawerHeader(
          decoration: const BoxDecoration(color: Colors.orange),
          currentAccountPicture: CircleAvatar(
            maxRadius: double.tryParse('44'),
            minRadius: double.tryParse('44'),
            backgroundColor: const Color.fromRGBO(255, 219, 126, 1),
          ),
          accountName: const Text(
            "EcoVibe Bistrô",
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
          ),
          accountEmail: const Text(
            "ecovibebistro@gourmet.com.br",
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white),
          )),
      Expanded(
        child: ListView(
          children: [
            ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/orders');
            },
            leading: const Icon(Icons.description_sharp),
            title: const Text(
              "Pedidos",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color.fromRGBO(131, 131, 131, 1)),
            )),
        ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/tables');
            },
            leading: const Icon(Icons.table_bar_rounded),
            title: const Text(
              "Mesas",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color.fromRGBO(131, 131, 131, 1)),
            )),
        ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/emphasis');
            },
            leading: const Icon(Icons.star),
            title: const Text(
              "Destaques",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color.fromRGBO(131, 131, 131, 1)),
            )),
        ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/newproduct');
            },
            leading: const Icon(Icons.add),
            title: const Text(
              "Novo Produto",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color.fromRGBO(131, 131, 131, 1)),
            )),
        ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/menu');
            },
            leading: const Icon(Icons.menu_book_outlined),
            title: const Text(
              "Meu cardápio",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color.fromRGBO(131, 131, 131, 1)),
            )),
        ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/category');
            },
            leading: const Icon(Icons.category_outlined),
            title: const Text(
              "Categoria",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color.fromRGBO(131, 131, 131, 1)),
            )),
        ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/account');
            },
            leading: const Icon(Icons.account_box),
            title: const Text(
              "Minha conta",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color.fromRGBO(131, 131, 131, 1)),
            )),
        ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/sales');
            },
            leading: const Icon(Icons.shopify_sharp),
            title: const Text(
              "Resumo de Vendas",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color.fromRGBO(131, 131, 131, 1)),
            )),
            ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/sales');
            },
            leading: const Icon(Icons.logout_rounded),
            title: const Text(
              "Sair",
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                  color: Color.fromRGBO(131, 131, 131, 1)),
            )),
          ],
        ),
      ),
      Padding(
        padding:  const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: SvgPicture.asset('lib/assets/epedidos.svg')
      )
    ]));
  }
}
