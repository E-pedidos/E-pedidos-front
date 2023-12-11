import 'dart:convert';
import 'package:e_pedidos_front/models/item_model.dart';
import 'package:e_pedidos_front/repositorys/filial_repository.dart';
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

    if (res.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(res.body);
      List<dynamic> listItem = data['itemsTrending'];
      List<ItemModel> listIsTrending =
          listItem.map((e) => ItemModel.fromJson(e)).toList();

      setState(() {
        items = listIsTrending;
        isLoading = false;
      });
    }
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
            Expanded(child: 
            ListView(
              children:[
                 Wrap(
                children: items.map((ItemModel item){
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(item.photoUrl!,  width: 165, height: 170, fit: BoxFit.cover,),
                          const SizedBox(height: 7,),
                          Text(item.name ?? '', style: const TextStyle(fontWeight: FontWeight.w500),),
                          Text('R\$ ${item.valor}', style: const TextStyle(fontWeight: FontWeight.w500))
                        ],
                      ),
                    ),
                  );
                }).toList()
                ),
              ]
            ))
          ],
        ),
      ),
    ));
  }
}
