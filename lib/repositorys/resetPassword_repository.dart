import 'dart:convert';

import 'package:e_pedidos_front/shared/services/api_config.dart';
import 'package:http/http.dart' as http;

class ResetPasswordRepository {
  final url = ApiConfig.baseUrl;

  Future<http.Response> resetPassword(String email) async {
      try{
        final res = await http.post(
          Uri.parse('$url/auth/forgotPassword'),
          headers: ApiConfig.headers,
          body: jsonEncode({"email": email})
        );
        return res;
      } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }
}