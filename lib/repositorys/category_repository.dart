import 'dart:convert';

import 'package:e_pedidos_front/shared/services/api_config.dart';
import 'package:e_pedidos_front/shared/utils/shared_preferences_utils.dart';
import 'package:http/http.dart' as http;

class CategoryRpository {
  final url = ApiConfig.baseUrl;
  SharedPreferencesUtils prefs = SharedPreferencesUtils();

  Future<http.Response> registerFilial(String name, String address) async {
    try {
      var token = await prefs.getToken();
      var idFilial = await prefs.getIdFilial();

      ApiConfig.setToken(token);

      var obj = {"name": name, "filialId": idFilial};

      final res = await http.post(Uri.parse('$url/foodCategorys'),
          headers: ApiConfig.headers, 
          body: jsonEncode(obj)
       );

      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }
}