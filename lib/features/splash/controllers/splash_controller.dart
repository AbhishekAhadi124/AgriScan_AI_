import 'package:agri_scan/routes/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(seconds: 5), () {
      Get.offNamed(MyRoutes.homeRoute);
    });
  }
}

// import 'dart:async';

// import 'package:agri_scan/core/utlis/pref_utils.dart';
// import 'package:agri_scan/routes/routes.dart';
// import 'package:get/get.dart';

// class SplashController extends GetxController {
//   Timer? _timer;

//   @override
//   void onReady() {
//     super.onReady();
//     _startSplashTimer();
//   }

//   /// Starts splash delay and decides navigation safely
//   void _startSplashTimer() {
//     _timer = Timer(const Duration(seconds: 3), _handleNavigation);
//   }

//   /// Handles navigation after splash
//   void _handleNavigation() {
//     // 🔐 Prevent navigation if controller is already disposed
//     if (isClosed) return;

//     final prefUtils = Get.find<PrefUtils>();

//     final bool isLoggedIn = prefUtils.getIsLogin();

//     // 🧭 Decide next route
//     if (isLoggedIn) {
//       Get.offAllNamed(MyRoutes.homeRoute);
//     } else {
//       Get.offAllNamed(MyRoutes.accountLinkRoute);
//     }
//   }

//   @override
//   void onClose() {
//     // 🧹 Cancel timer to avoid memory leaks
//     _timer?.cancel();
//     super.onClose();
//   }
// }
