import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_pedidos_front/shared/widgets/custom_button.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscureText = true;
  var emailController = TextEditingController(text: '');
  var passwordController = TextEditingController(text: '');

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
                  child: ListView(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset("lib/assets/logo.svg"),
                              const Text("E-Pedidos"),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.85,
                                padding: const EdgeInsets.all(17),
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(17)),
                                    color: Colors.white),
                                child: Column(
                                  children: [
                                    const Text('Preencha suas informações!'),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      controller: emailController,
                                      decoration: const InputDecoration(
                                          hintText: 'Digite seu Email',
                                          prefixIcon: Icon(Icons.email),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)))),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    TextField(
                                      controller: passwordController,
                                      obscureText: isObscureText,
                                      decoration: InputDecoration(
                                        hintText: 'Digite sua Senha',
                                        prefixIcon: const Icon(Icons.lock),
                                        suffixIcon: InkWell(
                                          child: Icon(isObscureText
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                          onTap: () {
                                            setState(() {
                                              isObscureText = !isObscureText;
                                            });
                                          },
                                        ),
                                        border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                       Navigator.of(context).pushReplacementNamed('/recoverPassword');
                                      },
                                      child: const Text('Esqueceu a senha?'),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                        width: double.infinity,
                                        child: CustomButton(
                                          text: 'Entrar',
                                          backgroundColor: const Color.fromRGBO(
                                              54, 148, 178, 1),
                                          onPressed: () {
                                            

                                            /* if (emailController.text.trim() ==
                                                    "email@email.com" &&
                                                passwordController.text.trim() ==
                                                    "123") {
                                              Navigator.of(context).pushReplacementNamed('/home');
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Erro ao efetuar o login")));
                                            } */
                                          },
                                        )),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 1,
                                      color:
                                          const Color.fromRGBO(118, 118, 118, 1),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text('Ainda não tem sua conta?'),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pushReplacementNamed('/register');
                                        },
                                        child: const Text('Cadastre-se',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromRGBO(
                                                    255, 130, 18, 1))))
                                  ],
                                ),
                              ),
                            ]),
                      )
                    ],
                  ),
                ))));
  }
}
