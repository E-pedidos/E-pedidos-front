class ApiConfig {
  static const String baseUrl = 'https://epedidosapp.info';
  static Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8',
    'Authorization': '',
  };

  static Map<String, String> multipartHeaders = {
    'Content-Type': 'multipart/form-data',
    'Charset': 'utf-8',
    'Authorization': '',
  };

  static void setToken(String token) {
    headers['Authorization'] = 'Bearer $token';
    multipartHeaders['Authorization'] = 'Bearer $token';
  }
}
