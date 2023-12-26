import 'package:e_pedidos_front/models/order_model.dart';
import 'package:e_pedidos_front/repositorys/order_repository.dart';
import 'package:e_pedidos_front/shared/widgets/custom_card_orders.dart';
import 'package:e_pedidos_front/shared/widgets/custom_layout.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  OrderRepository orderRepository = OrderRepository();
  List<OrderModel> order = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getOrder();
  }

  getOrder() async {
    var res = await orderRepository.getOrders();
    setState(() {
      order = res;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(31, 25, 31, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pedidos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const Text('Histórico de pedidos',
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
                : order.isEmpty
                    ? const Expanded(
                        child: Center(
                          child: Text("não há nenhuma filial cadastrada!"),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          itemCount: order.length,
                          itemBuilder: (context, index) {
                            return CardOrders(
                                text: 'Maria - Mesa 06 - Clique para ver',
                                svgPath: 'lib/assets/touch_icon.svg');
                          },
                        ),
                      ),
          ],
        ),
      ),
    ));
  }
}
