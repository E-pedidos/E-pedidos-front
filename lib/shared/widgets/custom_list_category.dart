import 'package:e_pedidos_front/repositorys/category_repository.dart';
import 'package:e_pedidos_front/shared/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:e_pedidos_front/shared/widgets/custom_icon_button.dart';

class CustomListCategory extends StatefulWidget {
  final String text;
  final bool isRemove;
  final String idFoodCategory;

  const CustomListCategory(
      {super.key,
      required this.text,
      required this.isRemove,
      required this.idFoodCategory});

  @override
  State<CustomListCategory> createState() => _CustomListCategoryState();
}

class _CustomListCategoryState extends State<CustomListCategory> {
  CategoryRpository categoryRpository = CategoryRpository();

  showEditCategory() {
    showDialog(
        context: context,
        builder: (BuildContext bc) {
          final TextEditingController editNameController =
              TextEditingController(text: '');

          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: Colors.white,
            child: SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width * 0.8,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 31, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Editar Categoria', textAlign: TextAlign.start),
                    TextFormField(
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
                      onChanged: (value) {
                        editNameController.text = value;
                      },
                      initialValue: widget.text,
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
                            var res =
                                await categoryRpository.updateFoodCategory(
                                    editNameController.text,
                                    widget.idFoodCategory);

                            if (res.statusCode == 202) {
                              Navigator.of(context)
                                  .pushReplacementNamed('/category');
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
 /*  */

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.isRemove
            ? CustomIconButton(
                icon: Icons.remove,
                backgroundColor: const Color.fromRGBO(255, 148, 148, 1),
                iconColor: const Color.fromRGBO(255, 0, 0, 1),
                onTap: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirmar Exclusão'),
                          content:
                              const Text('Tem certeza que deseja excluir?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Não'),
                            ),
                            TextButton(
                              onPressed: () async {
                                 var res = await categoryRpository.deleteFoodCategory(widget.idFoodCategory);

                                  if (res.statusCode == 204) {
                                    Navigator.of(context).pushReplacementNamed('/category');

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        padding: EdgeInsets.all(30),
                                        content: Text('Categoria deletada!'),
                                        behavior: SnackBarBehavior.floating,),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        padding: EdgeInsets.all(30),
                                        content: Text('erro ao tentar excluir'),
                                        behavior: SnackBarBehavior.floating,),
                                    );
                                  }
                              },
                              child: const Text('Sim'),
                            ),
                          ],
                        );
                      },
                    );
                })
            : Container(),
        widget.isRemove
            ? const SizedBox(
                width: 10,
              )
            : Container(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 6,
            ),
            Text(
              widget.text,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 6,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 1,
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(54, 148, 178, 1)),
            ),
          ],
        ),
        widget.isRemove
            ? Container()
            : CustomIconButton(
                icon: Icons.edit,
                backgroundColor: const Color.fromRGBO(54, 148, 178, 1),
                iconColor: Colors.white,
                onTap: () {
                  showEditCategory();
                },
              ),
      ],
    );
  }
}
