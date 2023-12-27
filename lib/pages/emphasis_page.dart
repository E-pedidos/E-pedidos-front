// ignore_for_file: use_build_context_synchronously
import 'package:e_pedidos_front/models/item_model.dart';
import 'package:e_pedidos_front/repositorys/filial_repository.dart';
import 'package:e_pedidos_front/shared/widgets/custom_card_emphasis.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';

class EmphasisPage extends StatefulWidget {
  const EmphasisPage({super.key});

  @override
  State<EmphasisPage> createState() => _EmphasisPageState();
}

class _EmphasisPageState extends State<EmphasisPage> {
  FilialRepository filialRepository = FilialRepository();
  bool isLoading = true;
  List<ItemModel> items = [];

  @override
  void initState() {
    super.initState();
    getEmphasis();
  }

  getEmphasis() async {
    var res = await filialRepository.getFilialsByQrCode();
    setState(() {
      items = res;
      isLoading = false;
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
              'Destaques',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const Text('Altere os seus destaques',
                style: TextStyle(
                    fontSize: 13,
                    color: Color.fromRGBO(61, 61, 61, 1),
                    fontWeight: FontWeight.w500)),
            const SizedBox(
              height: 17,
            ),
            isLoading
                ? const Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.orange,
                    )),
                  )
                : items.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: Text("não há destaques!"),
                        ),
                      )
                    :
            Expanded(
                child: ListView(children: [
              Wrap(
                children: items.map((ItemModel item) {
                return CustomCardEmphasis(
                    name: item.name!,
                    id: item.id!,
                    photoUrl: item.photoUrl!,
                    value: item.valor!);
              }).toList()),
            ]))
          ],
        ),
      ),
    ));
  }
}
