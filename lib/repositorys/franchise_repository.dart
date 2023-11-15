import 'dart:convert';

import 'package:e_pedidos_front/shared/services/api_config.dart';
import 'package:e_pedidos_front/shared/utils/shared_preferences_utils.dart';
import 'package:http/http.dart' as http;

class FranchiseRepository {
  final url = ApiConfig.baseUrl;
  SharedPreferencesUtils prefs = SharedPreferencesUtils();

  Future<http.Response> getFranchise() async {
    try {
      var token = await prefs.getToken();
      ApiConfig.setToken(token);

      final res = await http.get(
        Uri.parse('${url}/franchises/fromUser'),
        headers: ApiConfig.headers,
      );

      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<dynamic> registerFranchise(String name) async {
    try {
      var token = await prefs.getToken();

      ApiConfig.setToken(token);

      final res = await http.post(Uri.parse('${url}/franchises'),
          headers: ApiConfig.headers, body: jsonEncode({"name": name}));

      return res.body;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }
}
