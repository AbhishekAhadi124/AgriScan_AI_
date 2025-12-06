import 'package:agri_scan/core/utlis/logger.dart';
import 'package:agri_scan/features/profile/models/user_profile_model.dart';

class ProfileService {
  Future<UserProfile> getProfileData() async {
    try {
      // var res = await Get.find<ApiClient>().getRequest<UserProfile>('/api/profile/', isAuth: true,);
      // var data = UserProfile.fromJson(res.data);
      final mockData = {
        "name": "Abhi Aahadi",
        "email": "abhiahadi@example.com",
        "phone_number": 7770086870,
        "avatar": "assets/avatar/avatar1.png",
      };
      var data = UserProfile.fromJson(mockData);
      return data;
    } catch (error) {
      Logger.log('$error');
      rethrow;
    }
  }

  Future<List<UserProfile>> getProfileListData() async {
    try {
      // var res = await Get.find<ApiClient>().getRequest<UserProfile>('/api/profile/', isAuth: true,);
      // final data = res.data.map((json) => UserProfile.fromJson(json)).toList();
      final mockData = [
        {
          "name": "Yash Santosh Yadav",
          "email": "yashyadav@example.com",
          "phone_number": 9876543210,
          "avatar": "assets/avatar/avatar1.png",
        },
      ];
      final data = mockData.map((json) => UserProfile.fromJson(json)).toList();
      return data;
    } catch (error) {
      Logger.log('$error');
      rethrow;
    }
  }
}
