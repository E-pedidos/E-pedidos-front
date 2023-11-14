class ApiConfig {
  static const String baseUrl = 'http://epedidosapp.info:8000';
  static Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8',
    'Authorization': '', 
  };

  static void setToken(String token) {
    headers['Authorization'] = 'Bearer $token';
  }
}
