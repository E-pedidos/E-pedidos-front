import 'package:e_pedidos_front/blocs/filialBlocs/filial_bloc.dart';
import 'package:e_pedidos_front/blocs/filialBlocs/filial_event.dart';
import 'package:e_pedidos_front/blocs/filialBlocs/filial_state.dart';
import 'package:e_pedidos_front/blocs/orderBloc/order_bloc.dart';
import 'package:e_pedidos_front/blocs/orderBloc/order_event.dart';
import 'package:e_pedidos_front/blocs/orderBloc/order_state.dart';
import 'package:e_pedidos_front/models/filial_model.dart';
import 'package:e_pedidos_front/shared/widgets/custom_container_list.dart';
import 'package:e_pedidos_front/shared/widgets/custom_container_tables.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? dropdownValue;
  late final FilialBloc _filialBloc;
  late final OrderBloc _orderBloc;

  @override
  void initState() {
    super.initState();
    _filialBloc = FilialBloc();
    _filialBloc.add(GetFilial());
    _orderBloc = OrderBloc();
  }

  void getOrder(List<FilialModel> filials) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var filialStorage = sharedPreferences.getString('idFilial');

    if (filialStorage != null) {
      dropdownValue = filialStorage;
      await sharedPreferences.setString('idFilial', dropdownValue!);
    } else if (filialStorage == null && filials.isNotEmpty) {
      dropdownValue = filials[0].id.toString();
      await sharedPreferences.setString('idFilial', dropdownValue!);
    }

    _orderBloc.add(GetOrders());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FilialBloc>.value(value: _filialBloc),
        BlocProvider<OrderBloc>.value(value: _orderBloc),
      ],
      child: BlocBuilder<FilialBloc, FilialState>(builder: (context, state) {
        if (state is FilialLoadingState) {
          return const CustomLayout(
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                  child: CircularProgressIndicator(
                color: Colors.orange,
              )),
            ),
          );
        }
        if (state is FilialLoadedState) {
          final filials = state.filiais;
          getOrder(filials);
          return BlocBuilder<OrderBloc, OrderState>(
              builder: (context, stateOrder) {
            final orders = stateOrder.orders;
            if (stateOrder is OrderLoadingState) {
              return const CustomLayout(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                      child: CircularProgressIndicator(
                    color: Colors.orange,
                  )),
                ),
              );
            }
            if (stateOrder is OrderLoadedState) {
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
                                      color:
                                          const Color.fromRGBO(54, 148, 178, 1),
                                    ),
                                    onChanged: (String? newValue) async {
                                      SharedPreferences sharedPreferences =
                                          await SharedPreferences.getInstance();

                                      setState(() {
                                        dropdownValue = newValue!;
                                      });

                                      await sharedPreferences.setString(
                                          'idFilial', dropdownValue!);
                                      getOrder(filials);
                                    },
                                    items: filials.map((FilialModel filial) {
                                      return DropdownMenuItem<String>(
                                        value: filial.id!,
                                        child: Text(filial.name!.toString()),
                                      );
                                    }).toList())),
                        const Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 21),
                            child: Text(
                              'Mesas',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            )),
                        ConatainerTable(list: orders),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Pedidos',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 13,
                        ),
                        ConatainerList(list: orders)
                      ],
                    ),
                  ),
                ),
              );
            }
            return const SizedBox();
          });
        }
        return const SizedBox();
      }),
    );
  }
}
