import 'package:cpf_cnpj_validator/cnpj_validator.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
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
  String? nameEstablishment;
  String? name;
  String? email;
  String? phone;
  String? cpfCnpj;

  @override
  void initState() {
    super.initState();

    prefs.getUserFindData('name_estabelecimento').then((value) {
      setState(() {
        nameEstablishment = value;
      });
    });

    prefs.getUserFindData('email').then((value) {
      setState(() {
        email = value;
      });
    });

    prefs.getUserFindData('name').then((value) {
      setState(() {
        name = value;
      });
    });

    prefs.getUserFindData('tel_wpp').then((value) {
      setState(() {
        phone = value.toString();
      });
    });

    prefs.getUserFindData('cpf_cnpj').then((value) {
      setState(() {
        if (value.length == 11) {
          cpfCnpj = CPFValidator.format(value);
        }
        if (value.length == 14) {
          cpfCnpj = CNPJValidator.format(value);
        }
      });
    });
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
            const Text('Adicione o novo produto do seu cardápio',
                style: TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(61, 61, 61, 1),
                    fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 37,
            ),
            const Center(child: CustomAvatar()),
            Expanded(
              child: ListView(
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
                        backgroundColor: const Color.fromRGBO(255, 223, 107, 1),
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
                decoration: const InputDecoration(labelText: 'Nome da empresa'),
                onChanged: (value) {
                  editedNameEstablishment = value;
                },
                initialValue: editedNameEstablishment,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop({
                    'nameEstablishment': editedNameEstablishment,
                    'name': editedName,
                    'email': editedEmail,
                    'phone': editedPhone,
                    'cpfCnpj': editedCpfCnpj,
                  });
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        );
      },
    ).then((result) {
      if (result != null && result is Map<String, String>) {
        setState(() {
          nameEstablishment = result['nameEstablishment'];
          name = result['name'];
          email = result['email'];
          phone = result['phone'];
          cpfCnpj = result['cpfCnpj'];
        });
      }
    });
  }
}
