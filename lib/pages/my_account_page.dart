// ignore_for_file: use_build_context_synchronously
import 'dart:convert';

import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:e_pedidos_front/models/update_user_model.dart';
import 'package:e_pedidos_front/repositorys/franchise_repository.dart';
import 'package:e_pedidos_front/repositorys/user_repository.dart';
import 'package:e_pedidos_front/shared/utils/shared_preferences_utils.dart';
import 'package:e_pedidos_front/shared/widgets/custom_avatar.dart';
import 'package:e_pedidos_front/shared/widgets/custom_button.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({super.key});

  @override
  State<MyAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  SharedPreferencesUtils prefs = SharedPreferencesUtils();
  UserRepository userRepository = UserRepository();
  bool isLoading = true;
  String? nameEstablishment;
  String? name;
  String? email;
  String? phone;
  String? cpfCnpj;
  String? linkImage;

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  getDataUser (){
    userRepository.getUser().then((value) {
      setState(() {
        Map<String, dynamic> user = jsonDecode(value);

        name = user['name'];
        nameEstablishment = user['name_estabelecimento'];
        email = user['email'];
        phone = user['tel_wpp'].toString();
        linkImage = user['avatar_url'];
        

        var formartCnpjCpf = user['cpf_cnpj'].toString();
        if(formartCnpjCpf.length == 11){
          cpfCnpj = CPFValidator.format(formartCnpjCpf);
        }

        if(formartCnpjCpf.length == 14){
          cpfCnpj = CNPJValidator.format(formartCnpjCpf);
        }

        isLoading = false;
      });
    });
  }

  void _showEditDialog(
    BuildContext context,
    String? nameEstablishment,
    String? name,
    String? email,
    String? phone,
    String? cpfCnpj,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String editedNameEstablishment = nameEstablishment ?? '';
        String editedName = name ?? '';
        String editedEmail = email ?? '';
        String editedPhone = phone ?? '';
        String editedCpfCnpj = cpfCnpj ?? '';

        return AlertDialog(
          title: const Text('Editar campos'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: 'Nome da empresa'),
                onChanged: (value) {
                  editedNameEstablishment = value;
                },
                initialValue: editedNameEstablishment,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Responsável'),
                onChanged: (value) {
                  editedName = value;
                },
                initialValue: editedName,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'E-mail'),
                onChanged: (value) {
                  editedEmail = value;
                },
                initialValue: editedEmail,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Celular'),
                onChanged: (value) {
                  editedPhone = value;
                },
                initialValue: editedPhone,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'CPF/CNPJ'),
                onChanged: (value) {
                  editedCpfCnpj = value;
                },
                initialValue: editedCpfCnpj,
              ),
              CustomButton(
                  text: 'Salvar',
                  textColor: const Color.fromRGBO(23, 160, 53, 1),
                  backgroundColor: const Color.fromRGBO(100, 255, 106, 1),
                  onPressed: () async {
                    UserRepository userRepository = UserRepository();
                    FranchiseRepository franchiseRepository = FranchiseRepository();

                    UserUpdateModel updateUser = UserUpdateModel(
                      name: editedName,
                      email: editedEmail,
                      telWpp: editedPhone,
                      cpfCnpj: editedCpfCnpj,
                      nameEstabelecimento: editedNameEstablishment
                    );

                    var res = await userRepository.updateUser(updateUser);

                    if (res.statusCode == 202) {
                    franchiseRepository.updateFranchise(editedNameEstablishment).then((value){
                      if(value == 202){
                        Navigator.of(context).pushReplacementNamed('/account');      
                      }
                    });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                padding: const EdgeInsets.all(30),
                                content: Text('$res'),
                                behavior: SnackBarBehavior.floating,
                              ),
                        );
                    }
                }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(31, 25, 31, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Minha conta',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 37,
            ),
            Center(child: CustomAvatar(
              linkImage: linkImage,
            )),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView(
                      children: [
                        const SizedBox(
                          height: 35,
                        ),
                        ListTile(
                          leading: const Text('Nome da empresa:'),
                          title: Text('$nameEstablishment'),
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 1,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(54, 148, 178, 1)),
                        ),
                        ListTile(
                          leading: const Text('Responsável:'),
                          title: Text('$name'),
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 1,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(54, 148, 178, 1)),
                        ),
                        ListTile(
                          leading: const Text('E-mail:'),
                          title: Text('$email'),
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 1,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(54, 148, 178, 1)),
                        ),
                        ListTile(
                          leading: const Text('Celular:'),
                          title: Text('$phone'),
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 1,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(54, 148, 178, 1)),
                        ),
                        ListTile(
                          leading: const Text('CPF/CNPJ:'),
                          title: Text('$cpfCnpj'),
                          contentPadding: const EdgeInsets.all(0),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 1,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(54, 148, 178, 1)),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        SizedBox(
                          height: 50,
                          width: 178,
                          child: CustomButton(
                              text: 'Editar',
                              textColor: const Color.fromRGBO(150, 108, 0, 1),
                              backgroundColor:
                                  const Color.fromRGBO(255, 223, 107, 1),
                              onPressed: () {
                                _showEditDialog(
                                  context,
                                  nameEstablishment,
                                  name,
                                  email,
                                  phone,
                                  cpfCnpj,
                                );
                              }),
                        )
                      ],
                    ),
            )
          ],
        ),
      ),
    ));
  }
}
