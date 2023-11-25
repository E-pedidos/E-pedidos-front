import 'package:e_pedidos_front/models/filial_model.dart';
import 'package:e_pedidos_front/repositorys/filial_repository.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';
import 'package:e_pedidos_front/shared/widgets/custom_card_table.dart';
import 'package:e_pedidos_front/shared/widgets/custom_card_orders.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   FilialRepository filialRepository = FilialRepository();
  String dropdownValue = ''; 
  List<FilialModel> filials = [];

  @override
  void initState() {
    super.initState();
    getFilials();
  }

  getFilials() async {
    var res = await filialRepository.getFilials();
    setState(() {
      filials = res;
      if (filials.isNotEmpty) {
        dropdownValue = filials[0].id.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(31, 25, 31, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down),
                  style: const TextStyle(color: Colors.black, ),
                  underline: Container(
                    height: 2,
                    color: const Color.fromRGBO(54, 148, 178, 1),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: filials.map((FilialModel filial) {
                    return DropdownMenuItem<String>(
                      value: filial.id,
                      child: Text(filial.name.toString()),
                    );
                  }).toList(),
                ),
              ),
              const CardTables(),
              const SizedBox(
                height: 30,
              ),
              const Text(
                'Pedidos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 13,
              ),
              Expanded(
                  child: ListView(
                children: const [
                  CardOrders(
                    text: 'André - Mesa 01 - Sanduíche de espinafre',
                    svgPath: 'lib/assets/icons_orders/icon_green.svg',
                  ),
                  CardOrders(
                    text: 'André - Mesa 01 - Sanduíche de espinafre',
                    svgPath: 'lib/assets/icons_orders/icon_red.svg',
                  ),
                  CardOrders(
                    text: 'André - Mesa 01 - Sanduíche de espinafre',
                    svgPath: 'lib/assets/icons_orders/icon_yellow.svg',
                  ),
                  CardOrders(
                    text: 'André - Mesa 01 - Sanduíche de espinafre',
                    svgPath: 'lib/assets/icons_orders/icon_green.svg',
                  ),
                  CardOrders(
                    text: 'André - Mesa 01 - Sanduíche de espinafre',
                    svgPath: 'lib/assets/icons_orders/icon_yellow.svg',
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
