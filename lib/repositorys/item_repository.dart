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

      if(res.statusCode == 200){
        List<dynamic> list = jsonDecode(res.body);
        List<ItemModel> listItem = list.map((e) => ItemModel.fromJson(e)).toList();

        return listItem;
      } else {
        return 'Erro ao carregar lista';
      }
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }
}
