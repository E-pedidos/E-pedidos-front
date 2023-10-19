import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';
import 'package:e_pedidos_front/shared/widgets/custom_button.dart';
import 'package:e_pedidos_front/shared/widgets/custom_dropdown_button.dart';

class NewProductPage extends StatefulWidget {
  const NewProductPage({super.key});

  @override
  State<NewProductPage> createState() => _NewProductPageState();
}

class _NewProductPageState extends State<NewProductPage> {
  List<String> valores = ['valor', 'valor2', 'valor3'];
  String? itemSelected;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: CustomLayout(
          child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(31, 25, 31, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Novo Produto',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const Text('Adicione o novo produto do seu cardápio',
                  style: TextStyle(
                      fontSize: 13,
                      color: Color.fromRGBO(61, 61, 61, 1),
                      fontWeight: FontWeight.w500)),
              const SizedBox(
                height: 17,
              ),
              Expanded(
                child: ListView(
                  children: [
                    const Text(
                      'Imagem',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: double.tryParse('151'),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: const Color.fromRGBO(54, 148, 178, 1),
                                width: 2.0))),
                    const SizedBox(
                      height: 23,
                    ),
                    const Text(
                      'Nome',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
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
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Ingredientes',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
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
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Valor ',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
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
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Valor de produção',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
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
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Categoria',
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    CustomDropdownButton(
                      value: itemSelected,
                      items: valores,
                      onChanged: (item) {
                        setState(() {
                          itemSelected = item!;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    CustomButton(
                      onPressed: () {},
                      text: 'Concluir',
                      backgroundColor: const Color.fromRGBO(100, 255, 106, 1),
                      textColor: const Color.fromRGBO(23, 160, 53, 1),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
