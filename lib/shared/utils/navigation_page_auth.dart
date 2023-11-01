// ignore_for_file: use_build_context_synchronously

import 'package:e_pedidos_front/pages/home_page.dart';
import 'package:e_pedidos_front/pages/login_page.dart';
import 'package:flutter/material.dart';

class NavigationAuth {
  NavigationAuth();

  void navigation(BuildContext context, bool isToken) async {
    await Future.delayed(const Duration(seconds: 4));
    if (isToken) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }
}