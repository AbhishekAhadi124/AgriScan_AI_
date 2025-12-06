import 'package:flutter/material.dart';
import 'package:agri_scan/features/splash/controllers/splash_controller.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final splashController = Get.put(SplashController());

  @override
  void initState() {
    super.initState();
    splashController.onReady();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 186, 247, 191),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo/Icon
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 121, 255, 126),
                      Color.fromARGB(255, 89, 199, 93),
                      Colors.green,
                      Color.fromARGB(255, 43, 103, 45),
                      Color.fromARGB(255, 34, 83, 36),
                      Color.fromARGB(255, 27, 68, 28),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(Icons.eco, size: 80, color: Colors.white),
              ),
              const SizedBox(height: 24),
              const Text(
                "AgriScan AI",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
