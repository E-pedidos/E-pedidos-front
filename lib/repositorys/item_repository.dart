import 'dart:convert';

import 'package:e_pedidos_front/models/item_model.dart';
import 'package:e_pedidos_front/shared/services/api_config.dart';
import 'package:e_pedidos_front/shared/utils/shared_preferences_utils.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';

class ItemRepository {
  final url = ApiConfig.baseUrl;
  SharedPreferencesUtils prefs = SharedPreferencesUtils();

  Future<http.Response> registerItem({
    required String name,
    required String description,
    required double valor,
    required double productCost,
    required String foodCategoryId,
    required CroppedFile photo,
  }) async {
    try {
      String? token = await prefs.getToken();
      String? filialId = await prefs.getIdFilial();

      ApiConfig.setToken(token);

      var res = http.MultipartRequest(
        'POST',
        Uri.parse('$url/items'),
      );

      res.headers.addAll(ApiConfig.multipartHeaders);

      res.fields['name'] = name;
      res.fields['filialId'] = filialId;
      res.fields['description'] = description;
      res.fields['valor'] = valor.toString();
      res.fields['product_cost'] = productCost.toString();
      res.fields['foodcategoryId'] = foodCategoryId;

      var imageBytes = await photo.readAsBytes();

      String mimeType = 'image/jpeg';

      res.files.add(http.MultipartFile.fromBytes(
        'photo',
        imageBytes,
        filename: 'menuItem.jpg',
        contentType: MediaType.parse(mimeType),
      ));

      var response = await res.send();
      var responseData = await http.Response.fromStream(response);

      return responseData;
    } catch (e) {
      return http.Response('Error on the server', 500);
    }
  }

  Future<dynamic> getItemsFilial() async {
    try {
      var token = await prefs.getToken();
      var idFilial = await prefs.getIdFilial();

      ApiConfig.setToken(token);
      final res = await http.get(
        Uri.parse('$url/items/byFilialId/$idFilial'),
        headers: ApiConfig.headers,
      );

      if (res.statusCode == 200) {
        List<dynamic> list = jsonDecode(res.body);
        List<ItemModel> listItem =
            list.map((e) => ItemModel.fromJson(e)).toList();

        return listItem;
      } else {
        return 'Erro ao carregar lista';
      }
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<http.Response> updateItem(String idItem, String name,
      String description, double valor, double productCost) async {
    try {
      var token = await prefs.getToken();

      ApiConfig.setToken(token);

      var obj = {
        "name": name,
        "description": description,
        "valor": valor,
        "product_cost": productCost
      };

      final res = await http.put(Uri.parse('$url/items/$idItem'),
          headers: ApiConfig.headers, body: jsonEncode(obj));

      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<http.Response> updateIsTrending(String idItem) async {
    try {
      var token = await prefs.getToken();

      ApiConfig.setToken(token);

      final res = await http.put(
        Uri.parse('$url/items/changeTrend/$idItem'),
        headers: ApiConfig.headers,
      );

      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<http.Response> deleteItem(String id) async {
    try {
      var token = await prefs.getToken();
      ApiConfig.setToken(token);

      final res = await http.delete(
        Uri.parse('$url/items/$id'),
        headers: ApiConfig.headers,
      );

      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<http.Response> updateImageItem(CroppedFile image, String idItem) async {
    try {
      SharedPreferencesUtils prefs = SharedPreferencesUtils();
      String? token = await prefs.getToken();

      ApiConfig.setToken(token);

      var res = http.MultipartRequest(
        'PUT',
        Uri.parse('$url/items/addPhoto/$idItem'),
      );

      res.headers.addAll(ApiConfig.multipartHeaders);

      var imageBytes = await image.readAsBytes();

      String mimeType = 'image/jpeg';

      res.files.add(http.MultipartFile.fromBytes(
        'photo',
        imageBytes,
        filename: 'item.jpg',
        contentType: MediaType.parse(mimeType),
      ));

      var response = await res.send();

      var responseData = await response.stream.toBytes();

      var responseString = utf8.decode(responseData);

      if (response.statusCode == 202) {
        return http.Response(responseString, response.statusCode);
      } else {
        return http.Response(responseString, response.statusCode);
      }
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }
}
