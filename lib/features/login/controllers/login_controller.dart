import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;

  void login(String username, String password) {
    // implement login logic here
    // ignore: avoid_print
    print("User: $username, Password: $password");
  }
}
