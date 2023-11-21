import 'package:e_pedidos_front/shared/utils/navigation_page_auth.dart';
import 'package:e_pedidos_front/shared/utils/shared_preferences_utils.dart';
import 'package:e_pedidos_front/shared/utils/verify_token_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? email;
  String? store;
  SharedPreferencesUtils prefs = SharedPreferencesUtils();

  @override
  void initState() {
    super.initState();

    getNameEstablishment();
    getEmailt();
  }

  getNameEstablishment() {
    prefs.getUserData().then((value) {
      setState(() {
        store = value['name'];
      });
    });
  }

  getEmailt() {
    prefs.getUserData().then((value) {
      setState(() {
        email = value['email'];
      });
    });
  }
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
          accountName: Text(
            "$store",
            style: const TextStyle(
                fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
          ),
          accountEmail: Text(
            "$email",
            style: const TextStyle(
                fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white),
          )),
      Expanded(
        child: ListView(
          children: [
            ListTile(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/home');
                },
                leading: const Icon(Icons.home),
                title: const Text(
                  "Home",
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
                  Navigator.of(context).pushNamed('/filials');
                },
                leading: const Icon(Icons.shopping_cart),
                title: const Text(
                  "Filiais",
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
                  NavigationAuth auth = NavigationAuth();
                  SharedPreferencesUtils pres = SharedPreferencesUtils();
                  pres.clean();

                  VerifyToken.verifyTokenUser()
                      .then((token) => {auth.navigation(context, token)});
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
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: SvgPicture.asset('lib/assets/epedidos.svg'))
    ]));
  }
}
