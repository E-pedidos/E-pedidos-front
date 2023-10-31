import 'package:shared_preferences/shared_preferences.dart';

class VerifyToken {

   static Future<bool> verifyTokenUser() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance(); 

    String? token = sharedPreferences.getString('token');

    if(token == null){
      print('não tem');
      return false;
    }
    print('true');
    return true ;
  }

  static Future<String> TokenUser() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance(); 

    String? token = sharedPreferences.getString('token');

    if(token == null){
      return '';
    }
    return token;
  }
}