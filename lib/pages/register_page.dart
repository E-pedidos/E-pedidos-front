import 'package:e_pedidos_front/models/user_model.dart';
import 'package:e_pedidos_front/pages/login_page.dart';
import 'package:e_pedidos_front/repositorys/user_repository.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController cpfCnpjController = TextEditingController(text: '');
  final TextEditingController addressController = TextEditingController(text: '');
  final TextEditingController nameEstabelecimentoController = TextEditingController(text: '');
  final TextEditingController categoryController = TextEditingController(text: '');
  final TextEditingController passwordController = TextEditingController(text: '');
  final TextEditingController passwordConfirmController = TextEditingController(text: '');

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
                                    controller: nameController,
                                    decoration: const InputDecoration(
                                        hintText: 'Nome',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: emailController,
                                    decoration: const InputDecoration(
                                        hintText: 'Email',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: cpfCnpjController,
                                    decoration: const InputDecoration(
                                        hintText: 'Cpf ou Cnpj',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: addressController,
                                    decoration: const InputDecoration(
                                        hintText: 'Endereço',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: nameEstabelecimentoController,
                                    decoration: const InputDecoration(
                                        hintText: 'Nome do estabelecimento',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: categoryController,
                                    decoration: const InputDecoration(
                                        hintText: 'Categoria',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: passwordController,
                                    decoration: const InputDecoration(
                                        hintText: 'Senha',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: passwordConfirmController,
                                    decoration: const InputDecoration(
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
                                        final name = nameController.text;
                                        final email = emailController.text;
                                        final cpfCnpj = cpfCnpjController.text;
                                        final address = addressController.text;
                                        final nameEstabelecimento = nameEstabelecimentoController.text;
                                        final category = categoryController.text;
                                        final password = passwordController.text;

                                        final user = UserModel(
                                          name: name,
                                          nameEstabelecimento: nameEstabelecimento,
                                          cpfCnpj: cpfCnpj,
                                          email: email,
                                          telWpp: 0,
                                          address: address,
                                          category: category,
                                          password: password,
                                        );
                                     
                                      UserRepository userRepository = UserRepository();

                                      userRepository.registerUser(user).then((_) {
                                          /* setState(() {
                                              isRegistered = true;
                                              Future.delayed(const Duration(seconds: 2), () {
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                                            });
                                          }); */
                                        }).catchError((error) {
                                        print(error);
                                      });
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
