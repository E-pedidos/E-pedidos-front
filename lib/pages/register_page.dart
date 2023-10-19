import 'package:e_pedidos_front/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_pedidos_front/shared/widgets/custom_button.dart';
import 'package:e_pedidos_front/shared/widgets/custom_alert.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isRegistered = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange,
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: ListView(children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('lib/assets/background.png'),
                fit: BoxFit.cover,
              )),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    SvgPicture.asset("lib/assets/logo.svg"),
                    const Text("E-Pedidos"),
                    const SizedBox(
                      height: 20,
                    ),
                    isRegistered
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomAlert(
                                    imageSvg: SvgPicture.asset(
                                        'lib/assets/verified.svg'),
                                    text: 'Cadastro concluído',
                                    backgroundColor: Colors.white,
                                    colorText:
                                        const Color.fromRGBO(23, 160, 53, 1))
                              ],
                            ),
                          )
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
                                    'Preencha os dados para fazer o cadastro'),
                                const SizedBox(
                                  height: 10,
                                ),
                                const TextField(
                                  decoration: InputDecoration(
                                      hintText: 'Nome',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)))),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const TextField(
                                  decoration: InputDecoration(
                                      hintText: 'Email',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)))),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const TextField(
                                  decoration: InputDecoration(
                                      hintText: 'Cpf ou Cnpj',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)))),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const TextField(
                                  decoration: InputDecoration(
                                      hintText: 'Endereço',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)))),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const TextField(
                                  decoration: InputDecoration(
                                      hintText: 'Nome do estabelecimento',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)))),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const TextField(
                                  decoration: InputDecoration(
                                      hintText: 'Categoria',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)))),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const TextField(
                                  decoration: InputDecoration(
                                      hintText: 'Senha',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)))),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const TextField(
                                  decoration: InputDecoration(
                                      hintText: 'Confirme a senha',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)))),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomButton(
                                  text: 'Cadastrar',
                                  backgroundColor:
                                      const Color.fromRGBO(54, 148, 178, 1),
                                  onPressed: () {
                                    setState(() {
                                      isRegistered = !isRegistered;
                                      Future.delayed(const Duration(seconds: 2),
                                          () {
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
                    const SizedBox(
                      height: 15,
                    )
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}
