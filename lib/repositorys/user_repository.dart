// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:e_pedidos_front/models/user_model.dart';
import 'package:e_pedidos_front/shared/services/api_config.dart';
import 'package:http/http.dart' as http;


class UserRepository {
  Future<http.Response> registerUser(UserModel user) async {
    final url = Uri.parse('${ApiConfig.baseUrl}/auth/register');

    try {
      final response = await http.post(
        url,
        headers: ApiConfig.headers, 
        body: json.encode(user),
      );

      return response;
    } catch (e) {
      print('Erro ao fazer a solicitação: $e');
      return http.Response('Erro na solicitação', 500);
    }
  }
}

