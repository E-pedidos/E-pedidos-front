import 'package:e_pedidos_front/shared/services/api_config.dart';
import 'package:http/http.dart' as http;


class FranchiseRepository {
  final url = ApiConfig.baseUrl;

  Future<http.Response> getFranchise(String token, String idUser) async {
    try {
      ApiConfig.setToken(token);

      final res = await http.get(
          Uri.parse('${url}/franchises/$idUser'),
          headers: ApiConfig.headers,
        );

      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }

  Future<http.Response> registerFranchise(String token, String idUser) async {
    try {
      ApiConfig.setToken(token);
      
      final res = await http.get(
          Uri.parse('${url}/franchises/$idUser'),
          headers: ApiConfig.headers,
        );

      return res;
    } catch (e) {
      return http.Response('Erro na solicitação', 500);
    }
  }
}