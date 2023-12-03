import 'package:e_pedidos_front/shared/services/api_config.dart';
import 'package:http/http.dart' as http;

class CategoryRepositoryPlans {
  final url = ApiConfig.baseUrl;

  Future<http.Response> getAllCategorys () async{
    try{
      final res = await http.get(Uri.parse('$url/categorys'),
          headers: ApiConfig.headers, 
       );

       return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }
}