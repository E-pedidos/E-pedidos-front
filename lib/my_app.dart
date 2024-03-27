import 'package:e_pedidos_front/pages/category_page.dart';
import 'package:e_pedidos_front/pages/emphasis_page.dart';
import 'package:e_pedidos_front/pages/filial_page.dart';
import 'package:e_pedidos_front/pages/home_page.dart';
import 'package:e_pedidos_front/pages/initial_page.dart';
import 'package:e_pedidos_front/pages/login_page.dart';
import 'package:e_pedidos_front/pages/my_account_page.dart';
import 'package:e_pedidos_front/pages/my_menu_page.dart';
import 'package:e_pedidos_front/pages/new_product_page.dart';
import 'package:e_pedidos_front/pages/orders_page.dart';
import 'package:e_pedidos_front/pages/qr_code_page.dart';
import 'package:e_pedidos_front/pages/recover_password.dart';
import 'package:e_pedidos_front/pages/register_page.dart';
import 'package:e_pedidos_front/pages/sales_page.dart';
import 'package:e_pedidos_front/pages/tables_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-pedidos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.orange),
      initialRoute: '/',
      routes: {
        '/': (context) => const InitialPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context)=>const RegisterPage(),
        '/recoverPassword' :(context)=> const RecoverPassword(),
        '/home': (context) => const HomePage(),
        '/orders': (context) => const OrdersPage(),
        '/tables' : (context) => const TablePage(),
        '/emphasis' : (context) => const EmphasisPage(),
        '/newproduct' : (context) => const NewProductPage(),
        '/menu' : (context) => const MyMenuPage(),
        '/category' : (context) => const CategoryPage(), 
        '/account' : (context) => const MyAccountPage(),
        '/sales' : (context) => const SalesPage(),
        '/filials' : (context) => const FilialPage(),
        '/qrcode' : (context) => const QrCodePage(),
      }
    );
  }
}
