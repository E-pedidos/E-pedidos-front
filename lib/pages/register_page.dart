import 'dart:convert';

import 'package:e_pedidos_front/models/user_model.dart';
import 'package:e_pedidos_front/pages/login_page.dart';
import 'package:e_pedidos_front/repositorys/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_pedidos_front/shared/widgets/custom_button.dart';
import 'package:e_pedidos_front/shared/widgets/custom_alert.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:cpf_cnpj_validator/cnpj_validator.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool isRegistered = false;
  final _nameController = TextEditingController(text: '');
  final _emailController = TextEditingController(text: '');
  final _telwppController = TextEditingController(text: '');
  final _cpfCnpjController = TextEditingController(text: '');
  final _addressController = TextEditingController(text: '');
  final _nameEstabelecimentoController = TextEditingController(text: '');
  final _categoryIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _passwordConfirmController = TextEditingController(text: '');
  bool isObscureText = true;

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
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const Text(
                                      'Preencha os dados para fazer o cadastro'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _nameController,
                                    decoration: const InputDecoration(
                                        hintText: 'Nome Completo',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "O nome deve ser preenchido!"),
                                              behavior: SnackBarBehavior.floating,
                                        ));
                                        return "O nome deve ser preenchido!";
                                      }

                                      if (value.length < 3) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "O nome precisa ter no mínimo 3 letras!"),
                                              behavior: SnackBarBehavior.floating,
                                        ));
                                        return "O nome precisa ter no mínimo 3 letras!";
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                        hintText: 'Email',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "O email deve ser preenchido!"),
                                              behavior: SnackBarBehavior.floating,
                                        ));
                                        return "O email deve ser preenchido!";
                                      }

                                      if (value.length < 5) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "O email precisa ter no mínimo 5 letras!"),
                                              behavior: SnackBarBehavior.floating,
                                        ));
                                        return "O email precisa ter no mínimo 5 letras!";
                                      }

                                      if (!value.contains('@') ||
                                          !value.contains('.com')) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text('email invalido'),
                                          behavior: SnackBarBehavior.floating,
                                        ));
                                        return 'email invalido';
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: _cpfCnpjController,
                                    decoration: const InputDecoration(
                                      hintText: 'CPF ou CNPJ',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text("O CPF ou CNPJ deve ser preenchido!"),
                                          behavior: SnackBarBehavior.floating,
                                        ));
                                        return "O CPF ou CNPJ deve ser preenchido!";
                                      }

                                      String cleanedValue =
                                          value.replaceAll(RegExp(r'\D'), '');

                                      if (cleanedValue.length != 11 &&
                                          cleanedValue.length != 14) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text("CPF ou CNPJ inválido"),
                                          behavior: SnackBarBehavior.floating,
                                        ));
                                        return "CPF ou CNPJ inválido";
                                      }

                                      if (cleanedValue.length == 11) {
                                        if (!CPFValidator.isValid(
                                            cleanedValue)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text("CPF inválido"),
                                            behavior: SnackBarBehavior.floating,
                                          ));
                                          return "CPF inválido";
                                        }
                                      } else if (cleanedValue.length == 14) {
                                        if (!CNPJValidator.isValid(
                                            cleanedValue)) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text("CNPJ inválido"),
                                            behavior: SnackBarBehavior.floating,
                                          ));
                                          return "CNPJ inválido";
                                        }
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: _telwppController,
                                    decoration: const InputDecoration(
                                        hintText: 'Cleular/Whatsapp',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "O Numero deve ser preenchido!"),
                                              behavior: SnackBarBehavior.floating,
                                        ));
                                        return "O Numero deve ser preenchido!";
                                      }

                                      if (value.length < 11) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Numero de telefone invalido! (DDD + Numero)"),
                                              behavior: SnackBarBehavior.floating,
                                        ));
                                        return "Numero de telefone invalido! (DDD + Numero)";
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _addressController,
                                    decoration: const InputDecoration(
                                        hintText: 'Endereço',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "O endereço deve ser preenchido!"),
                                              behavior: SnackBarBehavior.floating,
                                        ));
                                        return "O endereço deve ser preenchido!";
                                      }

                                      if (value.length < 8) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "Endereco invalido! precisa ter no mínimo 8 letras!"),
                                              behavior: SnackBarBehavior.floating,
                                        ));
                                        return "Endereco invalido! precisa ter no mínimo 8 letras!";
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _nameEstabelecimentoController,
                                    decoration: const InputDecoration(
                                        hintText: 'Nome do estabelecimento',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "O estabelecimento deve ser preenchido!"),
                                              behavior: SnackBarBehavior.floating,
                                        ));
                                        return "O estabelecimento deve ser preenchido!";
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _categoryIdController,
                                    decoration: const InputDecoration(
                                        hintText: 'Categoria',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content:
                                              Text("Selecione sua categoria"),
                                              behavior: SnackBarBehavior.floating,
                                        ));
                                        return "Selecione sua categoria";
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: isObscureText,
                                    decoration: InputDecoration(
                                      hintText: 'Senha',
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
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "A senha deve ser preenchido!"),
                                              behavior: SnackBarBehavior.floating,
                                        ));
                                        return "A senha deve ser preenchido!";
                                      }

                                      if (value.length <= 7) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "A senha precisa ter no minimo 8 digitos."),
                                              behavior: SnackBarBehavior.floating,
                                        ));
                                        return "A senha precisa ter no minimo 8 digitos.";
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _passwordConfirmController,
                                    obscureText: isObscureText,
                                    decoration: InputDecoration(
                                      hintText: 'Confirme a senha',
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
                                      if (value != _passwordController.text) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "As senhas precisam ser iguais"),
                                              behavior: SnackBarBehavior.floating,
                                        ));
                                        return "As senhas precisam ser iguais";
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomButton(
                                    text: 'Cadastrar',
                                    backgroundColor:
                                        const Color.fromRGBO(54, 148, 178, 1),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        final user = UserModel(
                                          name: _nameController.text,
                                          nameEstabelecimento:
                                              _addressController.text,
                                          cpfCnpj: _cpfCnpjController.text,
                                          email: _emailController.text,
                                          telWpp: _telwppController.text,
                                          address: _addressController.text,
                                          categoryId:
                                              _categoryIdController.text,
                                          password: _passwordController.text,
                                        );

                                        UserRepository userRepository =
                                            UserRepository();

                                        try {
                                          var res = await userRepository
                                              .registerUser(user);

                                          if (res.statusCode == 201) {
                                            setState(() {
                                              isRegistered = true;
                                            });
                                            await Future.delayed(
                                                const Duration(seconds: 2), () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const LoginPage()));
                                            });
                                          } else {
                                            Map<String, dynamic> errorJson =
                                                jsonDecode(res.body);
                                            if (errorJson
                                                .containsKey('message')) {
                                              var message =
                                                  errorJson['message'];
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                    padding: const EdgeInsets.all(30),
                                                content: Text('$message'),
                                                behavior: SnackBarBehavior.floating,
                                              ));
                                            }
                                          }
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                "Erro ao efetuar o cadastro"),
                                          ));
                                        }
                                      }
                                    },
                                  )
                                ],
                              ),
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
