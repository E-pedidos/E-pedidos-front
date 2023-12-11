import 'package:e_pedidos_front/models/item_model.dart';
import 'package:e_pedidos_front/repositorys/item_repository.dart';
import 'package:e_pedidos_front/shared/widgets/custom_card_menu.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';

class MyMenuPage extends StatefulWidget {
  const MyMenuPage({super.key});

  @override
  State<MyMenuPage> createState() => _MyMenuPageState();
}

class _MyMenuPageState extends State<MyMenuPage> {
  ItemRepository itemRepository = ItemRepository();
  List<ItemModel> listItem = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getItemsFilial();
  }

  getItemsFilial() async {
    var res = await itemRepository.getItemsFilial();

    if (res.runtimeType == List<ItemModel>) {
      setState(() {
        listItem = res;
        isLoading = false;
      });
    }else{
       ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            padding: EdgeInsets.all(30),
            content: Text('Erro ao carregar itens!'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(31, 35, 31, 100),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Cardápio',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          isLoading
                ? const Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.orange,
                    )),
                  )
                : listItem.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: Text("não há nenhum item!"),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: listItem.length,
                          itemBuilder: (context, index) {
                            return CustomCardMenu(
                              description: listItem[index].description ?? '',
                              idItem: listItem[index].id ?? '',
                              image: listItem[index].photoUrl ?? '',
                              name: listItem[index].name ?? '',
                              price: listItem[index].valor ?? '0',
                              priceCus: listItem[index].productCost ?? '0',
                              isTrending: listItem[index].isTrending!,
                            );
                          },
                        ),
                      ),
        ]),
      ),
    ));
  }
}
