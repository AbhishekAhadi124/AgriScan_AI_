import 'dart:io';
import 'package:agri_scan/features/home/controllers/home_controller.dart';
import 'package:agri_scan/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  String currentLang = 'en';
  final controller = Get.put(HomeController());
  String finalResult = "";
  final Map<String, Map<String, String>> localizedValues = {
    'en': {
      'title': 'AgriScan AI',
      'welcome':
          'Hello! I\'m AgriScan. Ask about plant diseases or upload a photo.',
      'hint': 'Ask about plant diseases...',
      'new_chat': 'New Chat',
      'about': 'About Us',
      'lang_name': 'Language',
      'sent_photo': 'You sent a photo',
      'analyzing': 'Analyzing plant health...',
    },
    'hi': {
      'title': 'एग्रीस्कैन एआई',
      'welcome':
          'नमस्ते! मैं एग्रीस्कैन हूँ। पौधों की बीमारियों के बारे में पूछें।',
      'hint': 'पौधों की बीमारी के बारे में पूछें...',
      'new_chat': 'नई चैट',
      'about': 'हमारे बारे में',
      'lang_name': 'भाषा चुनें',
      'sent_photo': 'आपने एक फोटो भेजी',
      'analyzing': 'विश्लेषण कर रहा हूँ...',
    },
    'mr': {
      'title': 'एग्रीस्कॅन एआय',
      'welcome': 'नमस्कार! मी एग्रीस्कॅन आहे. वनस्पतींच्या रोगांबद्दल विचारा.',
      'hint': 'रोगांबद्दल विचारा...',
      'new_chat': 'नवीन चॅट',
      'about': 'आमच्याबद्दल',
      'lang_name': 'भाषा निवडा',
      'sent_photo': 'तुम्ही फोटो पाठवला आहे',
      'analyzing': 'विश्लेषण करत आहे...',
    },
  };

  String t(String key) => localizedValues[currentLang]?[key] ?? key;

  final List<String> messages = [];
  final promptC = TextEditingController();
  final speech = SpeechToText();
  final scrollController = ScrollController();
  bool isListening = false, canSend = false, isPickingImage = false;

  @override
  void initState() {
    super.initState();
    messages.add(t('welcome'));
  }

  void processImage(File image) async {
    await controller.classifyImage(image);
    String result = controller.resultText.value;

    if (result.startsWith("INVALID_PLANT")) {
      String userMessage = result.replaceAll("INVALID_PLANT: ", "");
      showInvalidDialog(userMessage);

      setState(() {
        messages.add("⚠️ Rejected. $userMessage");
      });
    } else {
      setState(() {
        finalResult = "Diagnosis: $result";
        messages.add(finalResult);
      });
    }
    scrollToBottom();
  }

  void showInvalidDialog(String message) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Invalid Image"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          0.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    promptC.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    if (isPickingImage) return;
    setState(() {
      isPickingImage = true;
    });

    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
      );

      if (image != null) {
        sendMessageWithAttachment(image.path, "");
      }
    } catch (e) {
      debugPrint('[Log] Error: $e');
    } finally {
      if (mounted) setState(() => isPickingImage = false);
    }
  }

  Future<void> takePhoto() async {
    if (isPickingImage) return;
    setState(() => isPickingImage = true);
    try {
      final cameraStatus = await Permission.camera.request();
      if (!cameraStatus.isGranted) return;
      final picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
      if (photo != null) {
        sendMessageWithAttachment(photo.path, "");
      }
    } catch (e) {
      debugPrint('[Log] takePhoto error: $e');
    } finally {
      if (mounted) setState(() => isPickingImage = false);
    }
  }

  Future<void> startListening() async {
    if (!speech.isListening) {
      final bool available = await speech.initialize();
      if (available) {
        setState(() => isListening = true);
        speech.listen(
          onResult: (result) {
            setState(() {
              promptC.text = result.recognizedWords;
              canSend = promptC.text.isNotEmpty;
            });
          },
        );
      }
    } else {
      speech.stop();
      setState(() => isListening = false);
    }
  }

  void sendMessage() {
    final text = promptC.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        messages.add("You: $text");
        simulateAIResponse(text);
        promptC.clear();
        canSend = false;
      });
      scrollToBottom();
    }
  }

  void sendMessageWithAttachment(String path, String classificationResult) {
    setState(() {
      messages.add("IMAGE:$path");
      messages.add(t('analyzing'));
    });
    scrollToBottom();
    processImage(File(path));
  }

  void simulateAIResponse(String userMessage) {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(
          () => messages.add(
            "I am an AI assistant. I can help identify plant diseases if you upload a photo.",
          ),
        );
        scrollToBottom();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          t('title'),
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              Container(
                height: 30,
                padding: EdgeInsets.all(20),
                color: Color(0xFF4CAF50),
              ),
              Container(
                height: 120,
                padding: EdgeInsets.all(20),
                color: Color(0xFF4CAF50),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white24,
                      ),
                      child: const Icon(
                        Icons.eco,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      'AgriScan',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.language, color: Color(0xFF4CAF50)),
                title: Text(t('lang_name')),
                trailing: DropdownButton<String>(
                  value: currentLang,
                  onChanged: (val) => setState(() => currentLang = val!),
                  items: const [
                    DropdownMenuItem(value: 'en', child: Text('English')),
                    DropdownMenuItem(value: 'hi', child: Text('हिंदी')),
                    DropdownMenuItem(value: 'mr', child: Text('मराठी')),
                  ],
                  elevation: 0,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.chat, color: Color(0xFF4CAF50)),
                title: Text(t('new_chat')),
                onTap: () => Get.offAllNamed(MyRoutes.homeRoute),
              ),
              ListTile(
                leading: const Icon(Icons.info, color: Color(0xFF4CAF50)),
                title: Text(t('about')),
                onTap: () => Get.offAllNamed(MyRoutes.aboutUsRoute),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              reverse: true,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[messages.length - 1 - index];
                final isImage = message.startsWith("IMAGE:");
                final isUser = message.startsWith('You:') || isImage;

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          isUser
                              ? const Color(0xFF4CAF50)
                              : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child:
                        isImage
                            ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(message.replaceFirst("IMAGE:", "")),
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  t('sent_photo'),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )
                            : Text(
                              isUser
                                  ? message.replaceAll('You: ', '')
                                  : message,
                              style: TextStyle(
                                color: isUser ? Colors.white : Colors.black87,
                                fontFamily: 'Poppins',
                              ),
                            ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Color(0xFF4CAF50)),
                  onPressed: pickImage,
                ),
                IconButton(
                  icon: const Icon(Icons.camera_alt, color: Color(0xFF4CAF50)),
                  onPressed: takePhoto,
                ),
                IconButton(
                  icon: Icon(
                    isListening ? Icons.mic_off : Icons.mic,
                    color: const Color(0xFF4CAF50),
                  ),
                  onPressed: startListening,
                ),
                Expanded(
                  child: TextField(
                    controller: promptC,
                    decoration: InputDecoration(
                      hintText: t('hint'),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                    ),
                    onChanged:
                        (val) =>
                            setState(() => canSend = val.trim().isNotEmpty),
                  ),
                ),
                const SizedBox(width: 5),
                CircleAvatar(
                  backgroundColor:
                      canSend ? const Color(0xFF4CAF50) : Colors.grey.shade400,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: canSend ? sendMessage : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
