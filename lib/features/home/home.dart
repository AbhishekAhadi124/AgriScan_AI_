import 'package:agri_scan/features/about_us/about_us.dart';
import 'package:agri_scan/features/login/login.dart';
import 'package:agri_scan/features/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> _messages = []; // In-memory messages for one-time chat
  final TextEditingController _textController = TextEditingController();
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;
  bool _canSend = false;

  @override
  void initState() {
    super.initState();
    _messages.add(
      "AI: Hello! I'm AgriScan AI. Ask about plant diseases or upload a photo for analysis.",
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final status = await Permission.photos.request();
    if (!status.isGranted) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gallery permission denied')),
      );
      return;
    }
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery); 
    if (image != null) {
      _sendMessageWithAttachment(image.path);
    }
  }

  Future<void> _takePhoto() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(
        // ignore: use_build_context_synchronously
        context,
      ).showSnackBar(const SnackBar(content: Text('Camera permission denied')));
      return;
    }
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      _sendMessageWithAttachment(photo.path);
    }
  }

  Future<void> _startListening() async {
    if (!_speech.isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) {
            setState(() {
              _textController.text = result.recognizedWords;
              _canSend = _textController.text.isNotEmpty;
            });
          },
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Voice recognition not available')),
        );
      }
    } else {
      _speech.stop();
      setState(() => _isListening = false);
    }
  }

  void _sendMessage() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add("You: $text");
        _simulateAIResponse(text);
        _textController.clear();
        _canSend = false;
      });
    }
  }

  void _sendMessageWithAttachment(String attachmentPath) {
    setState(() {
      _messages.add("You: [Photo attached: $attachmentPath]");
      _simulateAIResponse("Photo attached");
    });
  }

  void _simulateAIResponse(String userMessage) {
    String response =
        "AI: Analyzing your query... Based on '$userMessage', it might be a leaf disease. Upload more details for accuracy.";
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _messages.add(response); 
        });
      }
    });
  }

  void _newChat() {
    setState(() {
      _messages.clear(); // Clear messages for a new chat
      _messages.add("AI: Starting a new chat. How can I help with your crops?");
    });
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AgriScan AI',
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Color(0xFF4CAF50)),
                child: const Center(
                  child: Text(
                    'AgriScan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Color(0xFF4CAF50)),
                title: const Text(
                  'Profile',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Profile()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.chat, color: Color(0xFF4CAF50)),
                title: const Text(
                  'New Chat',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                onTap: () {
                  _newChat();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.login, color: Color(0xFF4CAF50)),
                title: const Text(
                  'Logout',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                onTap: () {
                  _logout();
                },
              ),
              ListTile(
                leading: const Icon(Icons.info, color: Color(0xFF4CAF50)),
                title: const Text(
                  'About Us',
                  style: TextStyle(fontFamily: 'Poppins'),
                ),
                onTap: () {
                  Navigator.pop(context); // Close drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutUs()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                final isUser = message.startsWith('You:');
                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser
                          ? const Color(0xFF4CAF50)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      message,
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
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border(top: BorderSide(color: Colors.grey.shade300)),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.attach_file, color: Color(0xFF4CAF50)),
                onPressed: _pickImage,
                tooltip: 'Attach Photo',
              ),
              IconButton(
                icon: const Icon(Icons.camera_alt, color: Color(0xFF4CAF50)),
                onPressed: _takePhoto,
                tooltip: 'Take Photo',
              ),
              IconButton(
                icon: Icon(
                  _isListening ? Icons.mic_off : Icons.mic,
                  color: const Color(0xFF4CAF50),
                ),
                onPressed: _startListening,
                tooltip: 'Voice Input',
              ),
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Ask about plant diseases...',
                    constraints: BoxConstraints.tightFor(height: 50),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: const BorderSide(color: Color(0xFF4CAF50)),
                    ),
                  ),
                  onChanged: (value) =>
                      setState(() => _canSend = value.trim().isNotEmpty),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Color(0xFF4CAF50)),
                onPressed: _canSend ? _sendMessage : null,
                tooltip: 'Send Message',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
