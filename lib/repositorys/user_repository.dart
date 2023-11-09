// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:e_pedidos_front/models/update_user_model.dart';
import 'package:e_pedidos_front/models/user_model.dart';
import 'package:e_pedidos_front/shared/services/api_config.dart';
import 'package:e_pedidos_front/shared/utils/shared_preferences_utils.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

      if (res.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        Map<String, dynamic> userData = jsonDecode(res.body);
        if (userData.containsKey('token')) {
          String userToken = userData['token'];

          await prefs.setString('token', userToken);
        }

        if (userData.containsKey('name_estabelecimento')) {
          String data = userData['name_estabelecimento'];

          await prefs.setString('name_estabelecimento', data);
        }

        if (userData.containsKey('email')) {
          String data = userData['email'];

          await prefs.setString('email', data);
        }

        if (userData.containsKey('category')) {
          String data = userData['category']['id'];

          await prefs.setString('categoryId', data);
        }

        if (userData.containsKey('id')) {
          String data = userData['id'];

          await prefs.setString('idUser', data);
        }

        ApiConfig.setToken(userData['token']);

        final franchises = await http.get(
          Uri.parse('${url}/franchises/${userData['id']}'),
          headers: ApiConfig.headers,
        );

        if (franchises.statusCode != 200) {
          final Registerfranchise = await http.post(
              Uri.parse('${url}/franchises'),
              headers: ApiConfig.headers,
              body: userData['name_estabelecimento']);
          print(Registerfranchise);
        }
      }
      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<http.Response> getUser() async {
    try {
      SharedPreferencesUtils prefs = SharedPreferencesUtils();
      String? token = await prefs.getToken();
      String? id = await prefs.getIdUser();

      ApiConfig.setToken(token);

      final res = await http.get(
        Uri.parse('${url}/users/${id}'),
        headers: ApiConfig.headers,
      );

      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<http.Response> updateUser(UserUpdateModel user) async {
    try {
      SharedPreferencesUtils prefs = SharedPreferencesUtils();
      String? token = await prefs.getToken();

      ApiConfig.setToken(token);
      final res = await http.patch(
        Uri.parse('${url}/users/profile'),
        headers: ApiConfig.headers,
        body: json.encode(user),
      );
      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }
}
