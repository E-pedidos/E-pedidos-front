import 'package:e_pedidos_front/blocs/filialBlocs/filial_bloc.dart';
import 'package:e_pedidos_front/blocs/filialBlocs/filial_event.dart';
import 'package:e_pedidos_front/blocs/filialBlocs/filial_state.dart';
import 'package:e_pedidos_front/shared/widgets/custom_button.dart';
import 'package:e_pedidos_front/shared/widgets/custom_card_filial.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilialPage extends StatefulWidget {
  const FilialPage({super.key});

  @override
  State<FilialPage> createState() => _FilialPageState();
}

class _FilialPageState extends State<FilialPage> {
  late final FilialBloc _filialBloc;

  @override
  void initState() {
    super.initState();
    _filialBloc = FilialBloc();
    _filialBloc.add(GetFilial());
  }

  void _createFilial(FilialBloc contextBuild) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final formKey = GlobalKey<FormState>();
        var nameController = TextEditingController(text: '');
        var addressController = TextEditingController(text: '');
        var pixController = TextEditingController(text: '');

        return AlertDialog(
          title: const Text('Crie sua filial'),
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
                          hintText: 'nome da filial'),
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
                    TextFormField(
                      controller: pixController,
                      decoration: const InputDecoration(
                          hintText: 'Se tiver pix, digite aqui'),
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
                    const SizedBox(height: 10,),
                    CustomButton(
                      text: 'Salvar',
                      textColor: const Color.fromRGBO(23, 160, 53, 1),
                      backgroundColor: const Color.fromRGBO(100, 255, 106, 1),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          _filialBloc.add(RegisterFilial(
                            name: nameController.text,
                            address: addressController.text,
                            pixKeyFromFilial: pixController.text,
                          ));

                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
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
        body: BlocBuilder<FilialBloc, FilialState>(
          bloc: _filialBloc,
          builder: (context, state) {
            if (state is FilialLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.orange,
                ),
              );
            }
            if (state is FilialLoadedState) {
              final filials = state.filiais;
              return Padding(
                padding: const EdgeInsets.fromLTRB(31, 25, 31, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Filiais',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 37,
                    ),
                    if (filials.isEmpty)
                      const Expanded(
                        child: Center(
                          child: Text("Não há nenhuma filial cadastrada!"),
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          itemCount: filials.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: (){
                                print('clique');
                                Navigator.pushNamed(context, '/qrcode'); 
                              },
                              child: CustomCardFilial(
                                name: filials[index].name ?? "",
                                id: filials[index].id ?? "",
                                address: filials[index].address ?? "",
                                filialBloc: _filialBloc,
                              ),
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
                          _createFilial(_filialBloc);
                        },
                      ),
                    )
                  ],
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _filialBloc.close();
    super.dispose();
  }
}
