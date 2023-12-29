import 'package:e_pedidos_front/blocs/filialBlocs/filial_bloc.dart';
import 'package:e_pedidos_front/blocs/filialBlocs/filial_event.dart';
import 'package:e_pedidos_front/repositorys/filial_repository.dart';
import 'package:e_pedidos_front/shared/widgets/custom_button.dart';
import 'package:e_pedidos_front/shared/widgets/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomCardFilial extends StatefulWidget {
  final String name;
  final String id;
  final String address;
  final FilialBloc filialBloc;

  const CustomCardFilial(
      {Key? key,
      required this.name,
      required this.id,
      required this.address,
      required this.filialBloc})
      : super(key: key);

  @override
  State<CustomCardFilial> createState() => _CustomCardFilialState();
}

class _CustomCardFilialState extends State<CustomCardFilial> {
  FilialRepository filialRepository = FilialRepository();

  void _showEditDialog(
    BuildContext context,
    String? nameFilial,
    String? addressFilial,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        List<String> nameParts = (nameFilial ?? '').split('-');
        String filial = nameParts.isNotEmpty ? nameParts.last.trim() : '';

        String editedNameFilial = filial;
        String editAddressFilial = addressFilial ?? '';

        return AlertDialog(
          title: const Text('Editar campos'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: 'Nome da filial'),
                onChanged: (value) {
                  editedNameFilial = value;
                },
                initialValue: editedNameFilial,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Responsável'),
                onChanged: (value) {
                  editAddressFilial = value;
                },
                initialValue: editAddressFilial,
              ),
              CustomButton(
                text: 'Salvar',
                textColor: const Color.fromRGBO(23, 160, 53, 1),
                backgroundColor: const Color.fromRGBO(100, 255, 106, 1),
                onPressed: () async {
                  widget.filialBloc.add(
                    UpdateFilial(
                        name: editedNameFilial,
                        address: editAddressFilial,
                        id: widget.id),
                  );
                  Future.delayed(const Duration(seconds: 1));
                   Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

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
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                widget.filialBloc
                                    .add(DeleteFilial(id: widget.id));
                                sharedPreferences.remove('idFilial');
                                Future.delayed(const Duration(seconds: 1));

                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    padding: EdgeInsets.all(30),
                                    content: Text('Filial Apagada!'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
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
                  onTap: () {
                    _showEditDialog(context, widget.name, widget.address);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
   widget.filialBloc.close();
    super.dispose();
  }
}
