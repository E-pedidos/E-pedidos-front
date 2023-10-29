// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:e_pedidos_front/models/user_model.dart';
import 'package:e_pedidos_front/shared/services/api_config.dart';
import 'package:http/http.dart' as http;


class UserRepository {
  final url = ApiConfig.baseUrl;

  Future<http.Response> registerUser(UserModel user) async {
    try {
      final res = await http.post(
        Uri.parse('$url/auth/register'),
        headers: ApiConfig.headers, 
        body: json.encode(user),
      );

      return res;
    } catch (e) {
      print('Erro ao fazer a solicitação: $e');
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<http.Response> loginUser(String email, String password) async{
    try{
      final res = await http.post(
          Uri.parse('$url/auth/login'),
          headers: ApiConfig.headers,
          body: json.encode({"email": email, "password": password})
      );

      return res;
    } catch (e) {
      print('Erro ao fazer a solicitação: $e');
      return http.Response('Erro na solicitação', 500);
    }
  }
}

