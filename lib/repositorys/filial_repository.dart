import 'dart:convert';

import 'package:e_pedidos_front/models/filial_model.dart';
import 'package:e_pedidos_front/models/item_model.dart';
import 'package:e_pedidos_front/shared/services/api_config.dart';
import 'package:e_pedidos_front/shared/utils/shared_preferences_utils.dart';
import 'package:http/http.dart' as http;

class FilialRepository {
  final url = ApiConfig.baseUrl;
  SharedPreferencesUtils prefs = SharedPreferencesUtils();

  Future<http.Response> registerFilial(
    String name, 
    String address, 
    String pixKeyFromFilial) async {
    try {
      var token = await prefs.getToken();
      var idFranchise = await prefs.getIdFranchise();
      ApiConfig.setToken(token);
      
      var obj = {
          "name": name,
          "pix_key_from_filial": pixKeyFromFilial,
          "address": address,
          "franchiseId": idFranchise
      };
      
      final res = await http.post(
        Uri.parse('$url/filials'),
        headers: ApiConfig.headers,
        body: jsonEncode(obj),
      );

      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<dynamic> getFilials() async {
    try {
      var token = await prefs.getToken();
      ApiConfig.setToken(token);

      final res = await http.get(
        Uri.parse('$url/filials/fromUser'),
        headers: ApiConfig.headers,
      );

      if (res.statusCode == 200) {
        List<dynamic> response = jsonDecode(res.body);
        List<FilialModel> list = response
            .map((filialData) => FilialModel.fromJson(filialData))
            .toList();

        return list;
      }
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<dynamic> deleteFilial(String id) async {
    try {
      var token = await prefs.getToken();
      ApiConfig.setToken(token);

      final res = await http.delete(
        Uri.parse('$url/filials/$id'),
        headers: ApiConfig.headers,
      );

      return res.statusCode;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<http.Response> updateFilial(
      String name, String address, String id) async {
    try {
      var token = await prefs.getToken();

      ApiConfig.setToken(token);

      var obj = {
        "name": name,
        "address": address,
      };

      final res = await http.put(Uri.parse('$url/filials/$id'),
          headers: ApiConfig.headers, body: jsonEncode(obj));

      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<dynamic> getFilialsByQrCode() async {
    try {
      var idFilial = await prefs.getIdFilial();
      var token = await prefs.getToken();
      ApiConfig.setToken(token);

      final res = await http.get(
        Uri.parse('$url/filials/getFilialByQrCode/$idFilial'),
        headers: ApiConfig.headers,
      );

      if (res.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(res.body);
        List<dynamic> listItem = data['itemsTrending'];
        List<ItemModel> listIsTrending =
            listItem.map((e) => ItemModel.fromJson(e)).toList();
        return listIsTrending;
      }
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<dynamic> getByQrCode() async {
    try {
      var idFilial = await prefs.getIdFilial();
      var token = await prefs.getToken();
      ApiConfig.setToken(token);

      final res = await http.get(
        Uri.parse('$url/filials/getFilialQrCode/$idFilial'),
        headers: ApiConfig.headers,
      );

      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }
}
