import 'package:agri_scan/features/about_us/about_us.dart';
// import 'package:agri_scan/features/account_link/account_link.dart';
import 'package:agri_scan/features/home/home.dart';
import 'package:agri_scan/features/home/bindings/home_bindings.dart';
// import 'package:agri_scan/features/login/bindings/login_bindings.dart';
// import 'package:agri_scan/features/login/login.dart';
import 'package:agri_scan/features/profile/profile.dart';
// import 'package:agri_scan/features/signup/signup.dart';
import 'package:agri_scan/features/splash/bindings/splash_bindings.dart';
import 'package:agri_scan/features/splash/splash.dart';
import 'package:get/get.dart';
import 'package:agri_scan/features/profile/profile_edit.dart';
import 'package:agri_scan/features/profile/bindings/profile_bindings.dart';

class MyRoutes {
  static String initialRoute = "/Splash";
  static String aboutUsRoute = "/AboutUs";
  static String accountLinkRoute = "/Acountlink";
  static String editProfileRoute = "/EditProfile";
  static String homeRoute = "/Home";
  static String loginRoute = "/Login";
  static String profileRoute = "/Profile";
  //static String settingRoute = "/Setting";
  static String signUpRoute = "/Signup";

  static List<GetPage> pages = [
    GetPage(
      name: initialRoute,
      page: () => const Splash(),
      binding: SplashBindings(),
    ),
    GetPage(name: aboutUsRoute, page: () => const AboutUs()),
    //GetPage(name: accountLinkRoute, page: () => const AccountLink()),
    GetPage(
      name: editProfileRoute,
      page: () => const ProfileEdit(),
      binding: ProfileBinding(),
    ),
    GetPage(name: homeRoute, page: () => const Home(), binding: HomeBinding()),
    // GetPage(name: loginRoute, page: () => const Login(), binding: LoginBinding()),
    GetPage(
      name: profileRoute,
      page: () => const Profile(),
      binding: ProfileBinding(),
    ),
    // GetPage(name: settingRoute, page: () => const Settings()),
    // GetPage(name: signUpRoute, page: () => const SignUp(), binding: LoginBinding()),
  ];
}
