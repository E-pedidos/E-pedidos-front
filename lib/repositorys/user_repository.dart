// ignore_for_file: avoid_print

import 'dart:convert';

import 'dart:io';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';

import 'package:e_pedidos_front/models/update_user_model.dart';
import 'package:e_pedidos_front/models/user_model.dart';
import 'package:e_pedidos_front/shared/services/api_config.dart';
import 'package:e_pedidos_front/shared/utils/shared_preferences_utils.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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

      ApiConfig.setToken(token);

      final res = await http.get(
        Uri.parse('$url/auth/getProfile'),
        headers: ApiConfig.headers,
      );

      if (res.statusCode == 200) {
        return res.body;
      }
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<dynamic> updateUser(UserUpdateModel user) async {
    SharedPreferencesUtils prefs = SharedPreferencesUtils();
    String? token = await prefs.getToken();
    try {
      ApiConfig.setToken(token);
      final res = await http.patch(
        Uri.parse('$url/users/profile'),
        headers: ApiConfig.headers,
        body: json.encode(user),
      );

      if (res.statusCode == 202) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        Map<String, dynamic> userData = jsonDecode(res.body);

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
        return res;
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
      print(e);
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<http.Response> uploudAvatarUser(Uint8List imageBytes) async {
  try {
    SharedPreferencesUtils prefs = SharedPreferencesUtils();
    String? token = await prefs.getToken();

    print('Token de autenticação: $token');
    ApiConfig.setToken(token);

    print('Criando solicitação...');
    var res = http.MultipartRequest(
      'PATCH',
      Uri.parse('$url/users/avatar'),
    );

    print('Configurando cabeçalhos...');
    res.headers.addAll(ApiConfig.multipartHeaders);

    print('Adicionando arquivo à solicitação...');

    // Obter o tipo MIME a partir dos bytes da imagem
    String mimeType = 'image/jpeg'; // ou 'image/png' dependendo do tipo da imagem

    // Adicionar bytes do arquivo à solicitação com contentType
    res.files.add(http.MultipartFile.fromBytes(
      'avatar',
      imageBytes,
      filename: 'avatar.jpg', // nome do arquivo a ser enviado
      contentType: MediaType.parse(mimeType),
    ));

    print('Enviando solicitação...');
    var response = await res.send();

    print('Recebendo resposta...');
    var responseData = await response.stream.toBytes();

    var responseString = utf8.decode(responseData);

    if (response.statusCode == 202) {
      print('Imagem enviada com sucesso!');
      print(responseString);
      return http.Response(responseString, response.statusCode);
    } else {
      print('Falha ao enviar imagem. Código de status: ${response.statusCode}');
      print(responseString);
      return http.Response(responseString, response.statusCode);
    }
  } catch (e) {
    print('Erro durante o processo: $e');
    return http.Response('Erro na solicitação', 500);
  }
}

}
