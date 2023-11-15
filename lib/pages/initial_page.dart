// ignore_for_file: use_build_context_synchronously
import 'package:e_pedidos_front/repositorys/franchise_repository.dart';
import 'package:e_pedidos_front/shared/utils/navigation_page_auth.dart';
import 'package:e_pedidos_front/shared/utils/verify_token_user.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}
  String getPeriodoDia() {
    var hora = DateTime.now().hour;

    if (hora >= 6 && hora < 12) {
      return 'Bom dia';
    } else if (hora >= 12 && hora < 18) {
      return 'Boa tarde';
    } else {
      return 'Boa noite';
    }
  }

class _InitialPageState extends State<InitialPage> {
  var saudation = getPeriodoDia();
  
  NavigationAuth navigationAuth = NavigationAuth();

  @override
  void initState() {
    super.initState();
    VerifyToken.verifyTokenUser().then((user) => {
      navigationAuth.navigation(context, user)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('lib/assets/logo.svg'),
            const SizedBox(
              height: 30,
            ),
            DefaultTextStyle(
              style: const TextStyle(
                fontSize: 40.0,
                fontFamily: 'Horizon',
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  RotateAnimatedText('Bem-vindo',),
                  RotateAnimatedText('${saudation}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
