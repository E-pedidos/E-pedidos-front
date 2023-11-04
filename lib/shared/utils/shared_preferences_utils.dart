import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {

  Future<dynamic> getUserFindData(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var jsonString = prefs.getString('userData');
    if (jsonString == null) {
      throw Exception('Dado não encontrado');
    }

    var userData = jsonDecode(jsonString);

    var data = userData['user']['$value'];

    return data;
  }

  Future<bool> clean() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.clear();
  }

}
