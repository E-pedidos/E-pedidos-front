import 'package:e_pedidos_front/shared/services/api_config.dart';
import 'package:e_pedidos_front/shared/utils/shared_preferences_utils.dart';
import 'package:http/http.dart' as http;

class OrderRepository {
  final url = ApiConfig.baseUrl;
  SharedPreferencesUtils prefs = SharedPreferencesUtils();

  Future<http.Response> getOrders() async {
    try {
      var token = await prefs.getToken();
      var idFilial = await prefs.getIdFilial();

      ApiConfig.setToken(token);

      final res = await http.get(
        Uri.parse("$url/orders/ordersFromFilial/$idFilial")
      );

      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }
}
