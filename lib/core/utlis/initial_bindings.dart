import 'package:agri_scan/core/app_export.dart';
import 'package:agri_scan/data/api_client/api_client.dart';
import 'package:agri_scan/core/utlis/pref_utils.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(PrefUtils());
    Get.put(ApiClient());
    Connectivity connectivity = Connectivity();
    Get.put(NetworkInfo(connectivity));
  }
}
