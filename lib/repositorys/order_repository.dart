import 'dart:convert';

import 'package:e_pedidos_front/models/order_model.dart';
import 'package:e_pedidos_front/shared/services/api_config.dart';
import 'package:e_pedidos_front/shared/utils/shared_preferences_utils.dart';
import 'package:http/http.dart' as http;

class OrderRepository {
  final url = ApiConfig.baseUrl;
  SharedPreferencesUtils prefs = SharedPreferencesUtils();

  Future<dynamic> getOrders() async {
    try {
      var token = await prefs.getToken();
      var idFilial = await prefs.getIdFilial();

      ApiConfig.setToken(token);

      final res = await http.get(
        Uri.parse("$url/orders/ordersFromFilial/$idFilial").replace(
          queryParameters: {
            'sort': 'desc'
          }
        ),
        headers: ApiConfig.headers,
      );

      if(res.statusCode == 200){
        Map<String, dynamic> dataOrder = jsonDecode(res.body);

        if(dataOrder.containsKey('data')){
          List<dynamic> listData = dataOrder['data'];
          List<OrderModel> list = listData.map((i) => OrderModel.fromJson(i)).toList();

          return list;
        }
      } else {
        return http.Response('Ocorreu um erro', res.statusCode);
      }
      
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }
}
