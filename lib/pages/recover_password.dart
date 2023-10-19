import 'package:e_pedidos_front/pages/login_page.dart';
import 'package:e_pedidos_front/shared/widgets/custom_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_pedidos_front/shared/widgets/custom_button.dart';

class RecoverPassword extends StatefulWidget {
  const RecoverPassword({super.key});

  @override
  State<RecoverPassword> createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  bool isSent = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.orange,
            body: ConstrainedBox(
                constraints: const BoxConstraints.expand(),
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('lib/assets/background.png'),
                    fit: BoxFit.cover,
                  )),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("lib/assets/logo.svg"),
                        const Text("E-Pedidos"),
                        const SizedBox(
                          height: 10,
                        ),
                        isSent
                            ? CustomAlert(
                                imageSvg:
                                    SvgPicture.asset('lib/assets/verified.svg'),
                                text: 'E-mail enviado',
                                backgroundColor:
                                    const Color.fromRGBO(23, 160, 53, 1),
                                colorText:
                                    const Color.fromRGBO(187, 255, 190, 1))
                            : Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                padding: const EdgeInsets.all(17),
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(17)),
                                    color: Colors.white),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Informe seu email, será enviado um link para definir sua nova senha!',
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const TextField(
                                      decoration: InputDecoration(
                                          hintText: 'Digite seu Email',
                                          prefixIcon: Icon(Icons.email),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)))),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CustomButton(
                                      text: 'Confirmar pelo e-mail',
                                      backgroundColor:
                                          const Color.fromRGBO(54, 148, 178, 1),
                                      onPressed: () {
                                        setState(() {
                                          isSent = !isSent;
                                          Future.delayed(
                                              const Duration(seconds: 2), () {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const LoginPage()));
                                          });
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                      ]),
                ))));
  }
}
