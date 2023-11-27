import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {

  Future<dynamic> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var nameEstabelecimento = prefs.getString('name_estabelecimento');
    var email = prefs.getString('email');
    var categoryId = prefs.getString('categoryId');
    var userId = prefs.getString('idUser');

    if (nameEstabelecimento == null){
      throw Exception('nome estabelecimento não encontrado');
    }

    if (email == null){
      throw Exception('email não encontrado');
    }

    if (categoryId == null){
      throw Exception('category id não encontrado');
    } 
    var userData = {
      "name": nameEstabelecimento,
      "email" : email,
      "categoryId" : categoryId,
      "id": userId
    };

  
    return userData;
  }

  Future<String> getIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var jsonString = prefs.getString('idUser');
    if (jsonString == null) {
      throw Exception('Dado não encontrado');
    }

    return jsonString;
  }

  Future<String> getIdFranchise() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var jsonString = prefs.getString('idFranchise');
    if (jsonString == null) {
      throw Exception('Dado não encontrado');
    }
    return jsonString;
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var jsonString = prefs.getString('token');
    if (jsonString == null) {
      throw Exception('Dado não encontrado');
    }

    return jsonString;
  }

  Future<String> getIdFilial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var jsonString = prefs.getString('idFilial');
    if (jsonString == null) {
      throw Exception('Dado não encontrado');
    }

    return jsonString;
  }

  Future<bool> clean() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.clear();
  }

}
