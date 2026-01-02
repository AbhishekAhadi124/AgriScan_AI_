// class Constants {
//   static String baseURL = 'http://192.168.0.102/api/login';
// }

class Constants {
  // Use your computer's current IP + the Port your Node.js app uses
  static String get baseURL => 'http://192.168.0.102';
  static const String _ip = '192.168.0.102';
  static const String _port = '6070';

  static const String apiBaseUrl = 'http://$_ip:$_port/api';

  // Endpoints
  static const String loginEndpoint = '$apiBaseUrl/users/login';
  static const String registerEndpoint = '$apiBaseUrl/farmers/register';
}
