import 'package:e_pedidos_front/models/filial_model.dart';
import 'package:e_pedidos_front/repositorys/filial_repository.dart';
import 'package:e_pedidos_front/shared/widgets/custom_button.dart';
import 'package:e_pedidos_front/shared/widgets/custom_card_filial.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';

class FilialPage extends StatefulWidget {
  const FilialPage({super.key});

  @override
  State<FilialPage> createState() => _FilialPageState();
}

class _FilialPageState extends State<FilialPage> {
  FilialRepository filialRepository = FilialRepository();
  List<FilialModel> filials = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getFilials();
  }

  getFilials() {
    filialRepository.getFilials().then((value) {
      setState(() {
        filials = value;
        isLoading = false;
      });
    });
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        var nameController = TextEditingController(text: '');
        var addressController = TextEditingController(text: '');

        return AlertDialog(
          title: const Text('Editar campos'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration:
                        const InputDecoration(hintText: 'Sub nome da franquia'),
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
                      backgroundColor: const Color.fromRGBO(100, 255, 106, 1),
                      onPressed: () async {
                        var res = await filialRepository.registerFilial(nameController.text, addressController.text);
                        print(res.body);
                        if(res.statusCode == 201){
                          Navigator.of(context).pushReplacementNamed('/filials');
                        }
                      }),
                ],
              )
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
            isLoading
                ? const Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.orange,
                    )),
                  )
                : filials.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: Text("não há nenhuma filial cadastrada!"),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: filials.length,
                          itemBuilder: (context, index) {
                            return CustomCardFilial(
                              name: filials[index].name ?? "",
                              id: filials[index].id ?? "",
                              address: filials[index].address ?? "",
                            );
                          },
                        ),
                      ),
            SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: CustomButton(
                  text: 'Criar Filial',
                  textColor: const Color.fromRGBO(23, 160, 53, 1),
                  backgroundColor: const Color.fromRGBO(100, 255, 106, 1),
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
