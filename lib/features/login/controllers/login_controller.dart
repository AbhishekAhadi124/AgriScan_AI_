import 'package:agri_scan/core/base/base_model.dart';
import 'package:agri_scan/core/utlis/pref_utils.dart';
import 'package:agri_scan/data/api_client/api_client.dart';
import 'package:agri_scan/features/login/models/login_request.dart';
import 'package:agri_scan/features/login/models/login_response.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var loginResponse = LoginResponse().obs;
  Future<void> login(BaseModel requestData) async {
    isLoading.value = true;
    try {
      final res = await Get.find<ApiClient>().postRequest(
        '/api/login/',
        LoginRequest as BaseModel,
        isAuth: false,
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        loginResponse.value = LoginResponse.fromJson(res.data);
        Get.find<PrefUtils>().setUser(loginResponse.value);
        Get.find<PrefUtils>().setIsLogin(true);
      } else {
        throw Exception("Login Failed with status: ${res.statusCode}");
      }
    } catch (e) {
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }
}
