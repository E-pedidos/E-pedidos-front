import 'dart:convert';

import 'package:e_pedidos_front/models/food_category_model.dart';
import 'package:e_pedidos_front/shared/services/api_config.dart';
import 'package:e_pedidos_front/shared/utils/shared_preferences_utils.dart';
import 'package:http/http.dart' as http;

class CategoryRpository {
  final url = ApiConfig.baseUrl;
  SharedPreferencesUtils prefs = SharedPreferencesUtils();

  Future<http.Response> registerFoodCategory(String name) async {
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

  Future<dynamic> getFoodCategory() async {
    try {
      var token = await prefs.getToken();
      var idFilial = await prefs.getIdFilial(); 

      ApiConfig.setToken(token);
      final res = await http.get(Uri.parse('$url/foodCategorys/fcFromFilial/$idFilial'),
          headers: ApiConfig.headers, 
       );

       if (res.statusCode == 200) {
        List<dynamic> response = jsonDecode(res.body);
        List<FoodCategory> list = response.map(
          (filialData) => FoodCategory.fromJson(filialData)
        ).toList();

        return list;
      } else {
        return [];
      }
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<http.Response> updateFoodCategory(String name, String idFoodCategorys) async {
    try {
      var token = await prefs.getToken();

      ApiConfig.setToken(token);

      var obj = {"name": name};

      final res = await http.put(Uri.parse('$url/foodCategorys/$idFoodCategorys'),
          headers: ApiConfig.headers, 
          body: jsonEncode(obj)
       );

      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<http.Response> deleteFoodCategory(String idFoodCategorys) async {
    try {
      var token = await prefs.getToken();
      
      ApiConfig.setToken(token);

      final res = await http.delete(Uri.parse('$url/foodCategorys/$idFoodCategorys'),
          headers: ApiConfig.headers, 
       );

      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }
}