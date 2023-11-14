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
        Uri.parse('$url/auth/register'),
        headers: ApiConfig.headers,
        body: json.encode(user),
      );

      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<dynamic> loginUser(String email, String password) async {
    try {
      final res = await http.post(Uri.parse('$url/auth/login'),
          headers: ApiConfig.headers,
          body: json.encode({"email": email, "password": password}));

      if (res.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        Map<String, dynamic> userData = jsonDecode(res.body);
        if (userData.containsKey('token')) {
          String userToken = userData['token'];

          await prefs.setString('token', userToken);
        }

        Map<String, dynamic> dataUser = userData['user'];


        if (dataUser.containsKey('name_estabelecimento')) {
          String data = dataUser['name_estabelecimento'];
         
          await prefs.setString('name_estabelecimento', data);
        }

        if (dataUser.containsKey('email')) {
          String data = dataUser['email'];
          
          await prefs.setString('email', data);
        }

        if (dataUser.containsKey('category')) {
          String data = dataUser['category']['id'];
          
          await prefs.setString('categoryId', data);
        }

        if (dataUser.containsKey('id')) {
          String data = dataUser['id'];
         
          await prefs.setString('idUser', data);
        }
        return res.statusCode;
      } else {
        Map<String, dynamic> errorJson = jsonDecode(res.body);

        if (errorJson.containsKey('validation')) {
          var validation = errorJson['validation'];
          if (validation.containsKey('body')) {
            var body = validation['body'];
            if (body.containsKey('message')) {
              var message = body['message'];
              return message;
            }
          }
        } else {
          var message = errorJson['message'];
          return message;
        }
      } 
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<dynamic> getUser() async {
    try {
      SharedPreferencesUtils prefs = SharedPreferencesUtils();
      String? token = await prefs.getToken();
      String? id = await prefs.getIdUser();

      ApiConfig.setToken(token);

      final res = await http.get(
        Uri.parse('$url/users/$id'),
        headers: ApiConfig.headers,
      );

  
      return res.body;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<http.Response> updateUser(UserUpdateModel user) async {
    SharedPreferencesUtils prefs = SharedPreferencesUtils();
    String? token = await prefs.getToken();
    try {
      print(token);
      ApiConfig.setToken(token);
      final res = await http.patch(
        Uri.parse('$url/users/profile'),
        headers: ApiConfig.headers,
        body: json.encode(user),
      );
      return res;
    } catch (e) {
      print(e);
      return http.Response('Erro na solicitação', 500);
    }
  }
}
