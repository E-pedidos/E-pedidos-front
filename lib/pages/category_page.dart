// ignore_for_file: sized_box_for_whitespace, use_build_context_synchronously

import 'package:e_pedidos_front/repositorys/category_repository.dart';
import 'package:e_pedidos_front/shared/widgets/custom_button.dart';
import 'package:e_pedidos_front/shared/widgets/custom_list_category.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  CategoryRpository categoryRpository = CategoryRpository();
  bool isRemove = false;

  showCreateCategory() {
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          final TextEditingController nameController =
              TextEditingController(text: '');

          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.white,
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 31, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Nome da Categoria', textAlign: TextAlign.start),
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 178,
                      height: 50,
                      child: CustomButton(
                          text: 'Concluir',
                          textColor: const Color.fromRGBO(23, 160, 53, 1),
                          backgroundColor:
                              const Color.fromRGBO(100, 255, 106, 1),
                          onPressed: () async {
                            var res = await categoryRpository.registerFilial(nameController.text);

                            if (res.statusCode == 201) {
                              Navigator.of(context).pushReplacementNamed('/category');
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  padding: EdgeInsets.all(30),
                                  content: Text('erro ao tentar cirar '),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          }),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(31, 25, 10, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Categorias',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const Text('Altere e adicione as suas categorias',
                style: TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(61, 61, 61, 1),
                    fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 29,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(54, 148, 178, 1)),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Minhas categorias',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 14,
            ),
            Expanded(
                child: ListView(
              children: [
                CustomListCategory(
                  text: 'Pratos',
                  isRemove: isRemove,
                ),
                CustomListCategory(
                  text: 'Almoço',
                  isRemove: isRemove,
                ),
                CustomListCategory(
                  text: 'Bebidas',
                  isRemove: isRemove,
                ),
                CustomListCategory(
                  text: 'Sucos',
                  isRemove: isRemove,
                )
              ],
            )),
            Center(
                child: Column(
              children: [
                isRemove
                    ? Container()
                    : CustomButton(
                        text: 'Adicionar categoria',
                        backgroundColor: const Color.fromRGBO(54, 148, 178, 1),
                        onPressed: () {
                          showCreateCategory();
                        }),
                isRemove
                    ? Container()
                    : CustomButton(
                        text: 'Remover categoria',
                        backgroundColor: const Color.fromRGBO(54, 148, 178, 1),
                        onPressed: () {
                          setState(() {
                            isRemove = !isRemove;
                          });
                        }),
                isRemove == false
                    ? Container()
                    : SizedBox(
                        height: 50,
                        width: 178,
                        child: CustomButton(
                            text: 'Concluir',
                            textColor: const Color.fromRGBO(23, 160, 53, 1),
                            backgroundColor:
                                const Color.fromRGBO(100, 255, 106, 1),
                            onPressed: () {
                              setState(() {
                                isRemove = !isRemove;
                              });
                            }),
                      )
              ],
            ))
          ],
        ),
      ),
    ));
  }
}
