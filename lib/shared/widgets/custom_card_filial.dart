import 'package:e_pedidos_front/repositorys/filial_repository.dart';
import 'package:e_pedidos_front/shared/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

class CustomCardFilial extends StatefulWidget {
  final String name;
  final String id;

  const CustomCardFilial({Key? key, required this.name, required this.id})
      : super(key: key);

  @override
  State<CustomCardFilial> createState() => _CustomCardFilialState();
}

class _CustomCardFilialState extends State<CustomCardFilial> {
  FilialRepository filialRepository = FilialRepository();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 19),
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
            Text(
              widget.name,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                CustomIconButton(
                  icon: Icons.remove,
                  backgroundColor: const Color.fromRGBO(255, 148, 148, 1),
                  iconColor: const Color.fromRGBO(255, 0, 0, 1),
                  onTap: () {
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
                                var res = await filialRepository
                                    .deleteFilial(widget.id);

                                if (res.statusCode == 204) {
                                  Navigator.of(context)
                                      .pushReplacementNamed('/filials');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      padding: EdgeInsets.all(30),
                                      content: Text('Filial Apagada!'),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                }
                              },
                              child: const Text('Sim'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  width: 4,
                ),
                CustomIconButton(
                  icon: Icons.edit,
                  backgroundColor: const Color.fromRGBO(54, 148, 178, 1),
                  iconColor: Colors.white,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
