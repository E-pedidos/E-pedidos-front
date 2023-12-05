import 'dart:io';
import 'dart:typed_data';

import 'package:e_pedidos_front/shared/services/api_config.dart';
import 'package:e_pedidos_front/shared/utils/shared_preferences_utils.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ItemRepository {
  final url = ApiConfig.baseUrl;
  SharedPreferencesUtils prefs = SharedPreferencesUtils();

  Future<http.Response> registerItem({
    required String name,
    required String description,
    required String valor,
    required double productCost,
    required String foodCategoryId,
    required File photo,
  }) async {
    try {
      String? token = await prefs.getToken();
      ApiConfig.setToken(token);

      var res = http.MultipartRequest(
        'POST',
        Uri.parse('$url/items'),
      );

      res.headers.addAll(ApiConfig.multipartHeaders);

      res.fields['name'] = name;
      res.fields['description'] = description;
      res.fields['valor'] = valor;
      res.fields['product_cost'] = productCost.toString();
      res.fields['foodcategoryId'] = foodCategoryId;

      var imageBytes = await photo.readAsBytes();
     
      String mimeType = 'image/jpeg';

      res.files.add(http.MultipartFile.fromBytes(
        'item',
        imageBytes,
        filename: 'menuItem.jpg',
        contentType: MediaType.parse(mimeType),
      ));

      var response = await res.send();
      var responseData = await http.Response.fromStream(response);
      print(responseData.body);
      return responseData;
    } catch (e) {
      print(e);
      return http.Response('Error on the server', 500);
    }
  }
}
