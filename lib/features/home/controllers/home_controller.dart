import 'package:agri_scan/features/home/services/home_services.dart';
import 'package:get/get.dart';
import 'dart:io';

class HomeController extends GetxController {
  RxString resultText = ''.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeModel();
  }

  Future<void> initializeModel() async {
    isLoading.value = true;
    try {
      await ClassifierService().initialize();
    } catch (e) {
      resultText.value = 'INVALID_PLANT: Failed to load AI models';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> classifyImage(File imageFile) async {
    isLoading.value = true;
    try {
      final result = await ClassifierService().processImage(imageFile);
      resultText.value = result;
    } catch (e) {
      resultText.value = 'INVALID_PLANT: Image processing failed';
    } finally {
      isLoading.value = false;
    }
  }
}
