import 'package:flutter/material.dart';

import 'ai_chat_screen.dart';
import 'ai_coach_screen.dart';

class AIScreen extends StatelessWidget {
  const AIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,

      child: Scaffold(
        backgroundColor: const Color(0xffF5F7FB),

        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "LifeRhythm AI",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),

          bottom: const TabBar(
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.grey,

            tabs: [

              Tab(
                icon: Icon(Icons.smart_toy),
                text: "Coach",
              ),

              Tab(
                icon: Icon(Icons.chat),
                text: "Chat",
              ),

            ],
          ),
        ),

        body: const TabBarView(
          children: [

            AICoachScreen(),

            AIChatScreen(),

          ],
        ),
      ),
    );
  }
}