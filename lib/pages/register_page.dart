import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:e_pedidos_front/models/user_model.dart';
import 'package:e_pedidos_front/pages/login_page.dart';
import 'package:e_pedidos_front/repositorys/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:e_pedidos_front/shared/widgets/custom_button.dart';
import 'package:e_pedidos_front/shared/widgets/custom_alert.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

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
                                      if(value == null || value.isEmpty){
                                          return "O nome deve ser preenchido!";
                                      }

                                      if(value.length < 3){
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
                                      if(value == null || value.isEmpty){
                                          return "O email deve ser preenchido!";
                                      }

                                      if(value.length < 5){
                                        return "O email precisa ter no mínimo 5 letras!";
                                      }

                                      if(!value.contains('@') || !value.contains('.com')){
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
                                        hintText: 'Cpf ou Cnpj',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                    validator: (value) {
                                      if(value == null || value.isEmpty){
                                          return "O Cfp ou Cnpj deve ser preenchido!";
                                      }

                                      if(!CPFValidator.isValid(value)){
                                        return 'Digite um Cfp ou Cnpj invalido';
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
                                      if(value == null || value.isEmpty){
                                          return "O Numero deve ser preenchido!";
                                      }

                                      if(value.length < 11){
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
                                      if(value == null || value.isEmpty){
                                          return "O endereço deve ser preenchido!";
                                      }

                                      if(value.length < 8){
                                        return "Endereco invalido! precisa ter no mínimo 8 letras! ";
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
                                      if(value == null || value.isEmpty){
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
                                      if(value == null || value.isEmpty){
                                          return "Selecione sua categoria1";
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    controller: _passwordController,
                                    decoration: const InputDecoration(
                                        hintText: 'Senha',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                    validator: (value) {
                                      if(value == null || value.isEmpty){
                                          return "A senha deve ser preenchido!";
                                      }

                                      if(value.length <= 7){
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
                                    decoration: const InputDecoration(
                                        hintText: 'Confirme a senha',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20)))),
                                    validator: (value) {
                                      if (value != _passwordController.text) {
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

                                         var res = await userRepository.registerUser(user);
                                          if(res.statusCode == 201){
                                             setState(() {
                                              isRegistered = true;
                                             });
                                            await Future.delayed(const Duration(seconds: 2),() {
                                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
                                            },);
                                          } else {
                                              // ignore: use_build_context_synchronously
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Erro ao efetuar o login")));
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
