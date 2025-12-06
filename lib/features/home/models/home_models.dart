class Message {
  final String text;
  final bool isUser; // true for user, false for AI
  final String? attachmentPath; // Optional: Path to attached file or photo
  final DateTime timestamp;

  Message({
    required this.text,
    required this.isUser,
    this.attachmentPath,
    required this.timestamp,
  });
}
