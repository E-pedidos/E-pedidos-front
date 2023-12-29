import 'package:e_pedidos_front/models/filial_model.dart';
import 'package:e_pedidos_front/models/order_model.dart';
import 'package:e_pedidos_front/repositorys/filial_repository.dart';
import 'package:e_pedidos_front/repositorys/order_repository.dart';
import 'package:e_pedidos_front/shared/widgets/custom_container_list.dart';
import 'package:e_pedidos_front/shared/widgets/custom_container_tables.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FilialRepository filialRepository = FilialRepository();
  OrderRepository orderRepository = OrderRepository();
  List<OrderModel> order = [];
  List<FilialModel> filials = [];
  String? dropdownValue = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getFilials();
    getOrder();
  }

  getFilials() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var res = await filialRepository.getFilials();
    var filialStorage = sharedPreferences.getString('idFilial');

    setState(() {
      filials = res;
      isLoading = false;
    });

    if (filialStorage != null) {
      dropdownValue = filialStorage;
    } else if (filials.isNotEmpty && filialStorage == null) {
      dropdownValue = filials[0].id.toString();
    }
  }

  getOrder() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var filialStorage = sharedPreferences.getString('idFilial');
    if (filialStorage != null) {
      var res = await orderRepository.getOrders();
      setState(() {
        order = res;
        isLoading = false;
      });
    } else {
      setState(() {
        order = [];
        isLoading = false;
      });
    }
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
              filials.isEmpty
                  ? const Center(
                      child: Text(
                      'Cadastre uma filial',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ))
                  : SizedBox(
                      width: double.infinity,
                      child: DropdownButton<String>(
                          value: dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                          underline: Container(
                            height: 2,
                            color: const Color.fromRGBO(54, 148, 178, 1),
                          ),
                          onChanged: (String? newValue) async {
                            SharedPreferences sharedPreferences =
                                await SharedPreferences.getInstance();

                            setState(() {
                              dropdownValue = newValue!;
                            });

                            await sharedPreferences.setString(
                                'idFilial', dropdownValue!);
                          },
                          items: filials.map((FilialModel filial) {
                            return DropdownMenuItem<String>(
                              value: filial.id!,
                              child: Text(filial.name!.toString()),
                            );
                          }).toList())),
              const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 21),
                  child: Text(
                    'Mesas',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )),
              ConatainerTable(isLoading: isLoading, list: order),
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
              ConatainerList(isLoading: isLoading, list: order)
            ],
          ),
        ),
      ),
    );
  }
}
