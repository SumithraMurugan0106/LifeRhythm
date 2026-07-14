import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../providers/gemini_provider.dart';
import '../../providers/user_provider.dart';

class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _controller = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  Future<void> _send() async {
    final text = _controller.text.trim();

    if (text.isEmpty) return;

    final userProvider = context.read<UserProvider>();

    final user = userProvider.user;

    if (user == null) return;

    _controller.clear();

    await context.read<GeminiProvider>().sendMessage(
      question: text,
      user: user,
    );

    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final gemini = context.watch<GeminiProvider>();

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "LifeRhythm AI",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<GeminiProvider>().clearChat();
            },
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),

      body: Column(
        children: [
          Expanded(
            child: gemini.messages.isEmpty
                ? const Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.smart_toy,
                      size: 90,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Hello 👋",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "I'm your LifeRhythm AI Coach.\n\nAsk me anything about\nProductivity • Career • Study • Sleep • Life Balance",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            )
                : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: gemini.messages.length,
              itemBuilder: (context, index) {
                final msg = gemini.messages[index];

                return Align(
                  alignment: msg.isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 14),
                    padding: const EdgeInsets.all(16),
                    constraints: BoxConstraints(
                      maxWidth:
                      MediaQuery.of(context).size.width * .75,
                    ),
                    decoration: BoxDecoration(
                      color: msg.isUser
                          ? AppColors.primary
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      msg.message,
                      style: TextStyle(
                        color: msg.isUser
                            ? Colors.white
                            : Colors.black87,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          if (gemini.isLoading)
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text("LifeRhythm AI is thinking..."),
                ],
              ),
            ),

          SafeArea(
            child: Container(
              padding: const EdgeInsets.all(14),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      minLines: 1,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: "Ask anything...",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.primary,
                    child: IconButton(
                      onPressed: gemini.isLoading ? null : _send,
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}