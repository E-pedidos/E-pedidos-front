import 'package:e_pedidos_front/repositorys/filial_repository.dart';
import 'package:e_pedidos_front/shared/widgets/custom_button.dart';
import 'package:e_pedidos_front/shared/widgets/custom_icon_button.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';

class FilialPage extends StatefulWidget {
  const FilialPage({super.key});

  @override
  State<FilialPage> createState() => _FilialPageState();
}

class _FilialPageState extends State<FilialPage> {
  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final formKey = GlobalKey<FormState>();
        var nameController = TextEditingController(text: '');
        var addressController = TextEditingController(text: '');

        return AlertDialog(
          title: const Text('Editar campos'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            hintText: 'Sub nome da franquia'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "O nome deve ser preenchido!";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: addressController,
                        decoration: const InputDecoration(hintText: 'endereço'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "O nome deve ser preenchido!";
                          }

                          if (value.length < 7) {
                            return "o endereço deve ter mais de 7 letras!";
                          }
                          return null;
                        },
                      ),
                      CustomButton(
                          text: 'Salvar',
                          textColor: const Color.fromRGBO(23, 160, 53, 1),
                          backgroundColor:
                              const Color.fromRGBO(100, 255, 106, 1),
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              FilialRepository filialRepository =
                                  FilialRepository();

                              filialRepository
                                  .registerFilial(nameController.text,
                                      addressController.text)
                                  .then((value) {
                                if (value.statusCode == 201) {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/filials');
                                }
                              });
                            }
                          }),
                    ],
                  ))
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
              'Filiais',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 37,
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 19),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromRGBO(54, 148, 178, 1),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Filial Teste',
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w500),
                          ),
                          Row(
                            children: [
                              CustomIconButton(
                                  icon: Icons.remove,
                                  backgroundColor:
                                      const Color.fromRGBO(255, 148, 148, 1),
                                  iconColor: const Color.fromRGBO(255, 0, 0, 1),
                                  onTap: () {}),
                              const SizedBox(
                                width: 4,
                              ),
                              CustomIconButton(
                                  icon: Icons.edit,
                                  backgroundColor:
                                      const Color.fromRGBO(54, 148, 178, 1),
                                  iconColor: Colors.white,
                                  onTap: () {}),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: CustomButton(
                  text: 'Editar',
                  textColor: const Color.fromRGBO(150, 108, 0, 1),
                  backgroundColor: const Color.fromRGBO(255, 223, 107, 1),
                  onPressed: () {
                    _showEditDialog();
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
