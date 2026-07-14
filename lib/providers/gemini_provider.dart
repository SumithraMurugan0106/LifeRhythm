import 'package:flutter/material.dart';

import '../models/chat_message.dart';
import '../models/user_model.dart';
import '../services/gemini_service.dart';

class GeminiProvider extends ChangeNotifier {
  final GeminiService _service = GeminiService();

  bool isLoading = false;

  String insight = "";

  final List<ChatMessage> _messages = [];

  List<ChatMessage> get messages => _messages;

  /// -----------------------------
  /// AI Coach Insight
  /// -----------------------------
  Future<void> generate({
    required String name,
    required double screenHours,
    required int productiveHours,
    required int lifeScore,
    required String careerGoal,
  }) async {
    isLoading = true;
    notifyListeners();

    insight = await _service.generateInsight(
      name: name,
      screenHours: screenHours,
      productiveHours: productiveHours,
      lifeScore: lifeScore,
      careerGoal: careerGoal,
    );

    isLoading = false;
    notifyListeners();
  }

  /// -----------------------------
  /// AI Chat
  /// -----------------------------
  Future<void> sendMessage({
    required String question,
    required UserModel user,
  }) async {
    if (question.trim().isEmpty) return;

    // User message
    _messages.add(
      ChatMessage(
        message: question,
        isUser: true,
        time: DateTime.now(),
      ),
    );

    isLoading = true;
    notifyListeners();

    final reply = await _service.askQuestion(
      question: question,
      user: user,
    );

    // AI reply
    _messages.add(
      ChatMessage(
        message: reply,
        isUser: false,
        time: DateTime.now(),
      ),
    );

    isLoading = false;
    notifyListeners();
  }

  /// -----------------------------
  /// Clear Chat
  /// -----------------------------
  void clearChat() {
    _messages.clear();
    notifyListeners();
  }
}