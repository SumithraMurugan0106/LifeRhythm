class ChatMessage {
  final String message;
  final bool isUser;
  final DateTime time;

  ChatMessage({
    required this.message,
    required this.isUser,
    required this.time,
  });

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      message: map["message"] ?? "",
      isUser: map["isUser"] ?? false,
      time: DateTime.parse(
        map["time"] ?? DateTime.now().toIso8601String(),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "message": message,
      "isUser": isUser,
      "time": time.toIso8601String(),
    };
  }

  ChatMessage copyWith({
    String? message,
    bool? isUser,
    DateTime? time,
  }) {
    return ChatMessage(
      message: message ?? this.message,
      isUser: isUser ?? this.isUser,
      time: time ?? this.time,
    );
  }
}