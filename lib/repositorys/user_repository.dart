import 'dart:convert';

import 'package:e_pedidos_front/models/user_model.dart';
import 'package:e_pedidos_front/services/api_config.dart';
import 'package:http/http.dart' as http;


class UserRepository {
 
  Future<void> registerUser(UserModel user) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/auth/register');

    try {
      final response = await http.post(
        url,
        headers: ApiConfig.headers, 
        body: json.encode(user),
      );

      if (response.statusCode == 200) {
       return print('deu certo');
      } 
    } catch (e) {
     return print(e);
    }
  }
}
