class ChatHistory {
  final String id;
  final String title;  // e.g., "Tomato Disease Query"
  final DateTime lastMessageTime;
  final List<Message> messages;  // Optional: full history

  ChatHistory({
    required this.id,
    required this.title,
    required this.lastMessageTime,
    this.messages = const [],
  });
}

class Message {
  get text => null;
}
// TODO Implement this library.