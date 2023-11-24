import 'dart:convert';

import 'package:e_pedidos_front/models/filial_model.dart';
import 'package:e_pedidos_front/shared/services/api_config.dart';
import 'package:e_pedidos_front/shared/utils/shared_preferences_utils.dart';
import 'package:http/http.dart' as http;

class FilialRepository {
  final url = ApiConfig.baseUrl;
  SharedPreferencesUtils prefs = SharedPreferencesUtils();

  Future<http.Response> registerFilial (String name, String address)async {
    try{
      var token = await prefs.getToken();
      var idFranchise = await prefs.getIdFranchise();

      ApiConfig.setToken(token);
      var obj = {
        "name": name,
        "address": address,
        "franchiseId": idFranchise
      };

      final res = await http.post(
        Uri.parse('$url/filials'),
        headers: ApiConfig.headers,
        body: jsonEncode(obj)
      );
   
      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<dynamic> getFilials ()async {
    try{
      var token = await prefs.getToken();
    ApiConfig.setToken(token);

    final res = await http.get(
      Uri.parse('$url/filials/fromUser'),
      headers: ApiConfig.headers,
    );

    if (res.statusCode == 200) {
      List<dynamic> response = jsonDecode(res.body);
      List<FilialModel> list = response.map((filialData) => FilialModel.fromJson(filialData)).toList();

      return list;
    } 
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<http.Response> deleteFilial (String id)async {
    try{
      var token = await prefs.getToken();
      ApiConfig.setToken(token);
      
      final res = await http.delete(
        Uri.parse('$url/filials/$id'),
        headers: ApiConfig.headers,
      );
   
      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<http.Response> updateFilial (String name, String address, String id)async {
    try{
      var token = await prefs.getToken();

      ApiConfig.setToken(token);

      var obj = {
        "name": name,
        "address": address,
      };

      final res = await http.put(
        Uri.parse('$url/filials/$id'),
        headers: ApiConfig.headers,
        body: jsonEncode(obj)
      );
      print(res.statusCode);
      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

}