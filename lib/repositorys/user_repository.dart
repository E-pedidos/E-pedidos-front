// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:e_pedidos_front/models/user_model.dart';
import 'package:e_pedidos_front/shared/services/api_config.dart';
import 'package:e_pedidos_front/shared/utils/shared_preferences_utils.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final url = ApiConfig.baseUrl;

  Future<http.Response> registerUser(UserModel user) async {
    try {
      final res = await http.post(
        Uri.parse('${url}/auth/register'),
        headers: ApiConfig.headers,
        body: json.encode(user),
      );
      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<http.Response> loginUser(String email, String password) async {
    try {
      final res = await http.post(Uri.parse('${url}/auth/login'),
          headers: ApiConfig.headers,
          body: json.encode({"email": email, "password": password}));

      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<http.Response> getUser() async {
    try {
      SharedPreferencesUtils prefs = SharedPreferencesUtils();
      String? token = await prefs.getToken();
      String? id = await prefs.getUserFindData('id');

      ApiConfig.setToken(token);


      final res = await http.get(Uri.parse('${url}/users/${id}'),
          headers: ApiConfig.headers,
      );

      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }  

  Future<http.Response> updateUser(UserModel user) async {
    try {
      SharedPreferencesUtils prefs = SharedPreferencesUtils();
      String? token = await prefs.getToken();

      ApiConfig.setToken(token);
      final res = await http.patch(
        Uri.parse('${url}/users/profile'),
        headers: ApiConfig.headers,
        body: json.encode(user),
      );
      print(res);
      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }
}
