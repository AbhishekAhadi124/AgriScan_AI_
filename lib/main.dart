import 'package:agri_scan/features/profile/controllers/profile_controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'routes/routes.dart';

Future<void> main() async {
  Get.put(ProfileController());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  Future<void> requestPermissions() async {
    await Permission.camera.request();
    await Permission.microphone.request();
    await Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // initialBinding: InitialBindings(),
      initialRoute: MyRoutes.initialRoute,
      getPages: MyRoutes.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
