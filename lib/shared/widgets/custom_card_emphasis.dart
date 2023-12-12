// ignore_for_file: use_build_context_synchronously

import 'package:e_pedidos_front/repositorys/item_repository.dart';
import 'package:e_pedidos_front/shared/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';

class CustomCardEmphasis extends StatefulWidget {
  final String name;
  final String id;
  final String photoUrl;
  final String value;

  const CustomCardEmphasis(
      {super.key,
      required this.name,
      required this.id,
      required this.photoUrl,
      required this.value});

  @override
  State<CustomCardEmphasis> createState() => _CustomCardEmphasisState();
}

class _CustomCardEmphasisState extends State<CustomCardEmphasis> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                widget.photoUrl,
                width: 165,
                height: 170,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                widget.name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text('R\$ ${widget.value}',
                  style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
          Positioned(
            child: Row(
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
                          content: const Text(
                              'Tem certeza que deseja tirar dos destaques?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Não'),
                            ),
                            TextButton(
                              onPressed: () async {
                                ItemRepository itemRepository =
                                    ItemRepository();

                                var res = await itemRepository
                                    .updateIsTrending(widget.id);

                                if (res.statusCode == 202) {
                                  Navigator.of(context).pushReplacementNamed('/emphasis');
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                    padding: const EdgeInsets.all(30),
                                    content: Text('${widget.name} não é Destaque!'),
                                    behavior: SnackBarBehavior.floating,
                                  ));
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
              ],
            ),
          )
        ]),
      ),
    );
  }
}
