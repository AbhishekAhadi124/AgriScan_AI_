import 'package:agri_scan/core/app_export.dart';
import 'package:agri_scan/core/utlis/logger.dart';
import 'package:agri_scan/data/api_client/api_client.dart';
import 'package:agri_scan/features/profile/models/user_profile_model.dart';
import 'package:agri_scan/features/profile/services/profile_services.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  Rx<UserProfile> profileData = UserProfile().obs;
  RxList<UserProfile> profileListData = <UserProfile>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    isLoading.value = true;
    try {
      UserProfile data = await ProfileService().getProfileData();
      profileData.value = data;
    } catch (error) {
      Logger.log('$error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProfileListData() async {
    isLoading.value = true;
    try {
      List<UserProfile> data = await ProfileService().getProfileListData();
      profileListData.assignAll(data);
    } catch (error) {
      Logger.log('$error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> submitProfileData(requestData) async {
    try {
      final res = await Get.find<ApiClient>().postRequest(
        '/api/update-profile/',
        requestData,
      );

      if (res.status == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      Logger.log('$error');
      return false;
    }
  }
}
