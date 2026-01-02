import 'package:agri_scan/features/home/services/home_services.dart';
import 'package:get/get.dart';
import 'dart:io';

class HomeController extends GetxController {
  final classifierService = ClassifierService();
  RxBool isLoading = false.obs;
  RxString resultText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initializeModel();
  }

  Future<void> initializeModel() async {
    try {
      isLoading.value = true;
      await classifierService.initialize();
    } catch (e) {
      resultText.value = 'INVALID_PLANT: Failed to load AI models';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> classifyImage(File imageFile) async {
    try {
      isLoading.value = true;
      final result = await classifierService.processImage(imageFile);
      resultText.value = result;
    } catch (e) {
      resultText.value = 'INVALID_PLANT: Image processing failed';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    classifierService.dispose();
    super.onClose();
  }
}
