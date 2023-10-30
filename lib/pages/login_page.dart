// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:e_pedidos_front/repositorys/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_pedidos_front/shared/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isObscureText = true;
  bool isLoading = false;
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
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      const Text('Preencha suas informações!'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: emailController,
                                        decoration: const InputDecoration(
                                            hintText: 'Digite seu Email',
                                            prefixIcon: Icon(Icons.email),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)))),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "O email deve ser preenchido!";
                                          }

                                          if (value.length < 5) {
                                            return "O email precisa ter no mínimo 5 letras!";
                                          }

                                          if (!value.contains('@') ||
                                              !value.contains('.com')) {
                                            return 'email invalido';
                                          }

                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
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
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "A senha deve ser preenchido!";
                                          }

                                          if (value.length <= 7) {
                                            return "A senha precisa ter no minimo 8 digitos.";
                                          }

                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .pushReplacementNamed(
                                                  '/recoverPassword');
                                        },
                                        child: const Text('Esqueceu a senha?'),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                          width: double.infinity,
                                          child: CustomButton(
                                            isLoading: isLoading,
                                            text: 'Entrar',
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    54, 148, 178, 1),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                UserRepository userRepository =
                                                    UserRepository();

                                                var res = await userRepository
                                                    .loginUser(
                                                        emailController.text,
                                                        passwordController
                                                            .text);

                                                if (res.statusCode == 200) {
                                                  SharedPreferences prefs = await SharedPreferences.getInstance();

                                                  String userDataString = res.body.toString();

                                                  await prefs.setString('userData', userDataString);
                                                  
                                                  Navigator.of(context).pushReplacementNamed('/home'); 
                                                } else {
                                                  setState(() {
                                                    isLoading = false;
                                                  });

                                                  Map<String, dynamic>
                                                      errorJson =
                                                      jsonDecode(res.body);
                                                  if (errorJson
                                                      .containsKey('message')) {
                                                    var message =
                                                        errorJson['message'];
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              30),
                                                      content: Text('$message'),
                                                    ));
                                                  }
                                                }
                                              }
                                            },
                                          )),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 1,
                                        color: const Color.fromRGBO(
                                            118, 118, 118, 1),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text('Ainda não tem sua conta?'),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pushNamed('/register');
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
                              ),
                            ]),
                      )
                    ],
                  ),
                ))));
  }
}
