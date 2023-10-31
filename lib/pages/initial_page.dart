// ignore_for_file: use_build_context_synchronously

import 'package:e_pedidos_front/pages/home_page.dart';
import 'package:e_pedidos_front/pages/login_page.dart';
import 'package:e_pedidos_front/shared/utils/verify_token_user.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {

  @override
  void initState() {
    super.initState();
    VerifyToken.verifyTokenUser().then((user) => {navigation(user)});
  }

  navigation(bool isToken) async {
    await Future.delayed(const Duration(seconds: 4));
    if (isToken) {
      Navigator.pushReplacement(context, 
          MaterialPageRoute(builder: (context)=> const HomePage()));
    } else {
      Navigator.pushReplacement(context, 
          MaterialPageRoute(builder: (context)=> const LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                const Text(
                  'E-pedidos',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Horizon',
                  ),
                ),
                SizedBox(height: 30,),
                DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 40.0,
                    fontFamily: 'Horizon',
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText('Bem-vindo', duration: const Duration(milliseconds: 800)),
                      RotateAnimatedText('Ao seu app',  duration: const Duration(milliseconds: 600)),
                      RotateAnimatedText('Aproveite!',  duration: const Duration(milliseconds: 600)),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
