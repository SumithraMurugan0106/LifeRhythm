import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/gemini_provider.dart';
import '../../providers/history_provider.dart';
import '../../providers/usage_provider.dart';
import '../../providers/user_provider.dart';
import 'widgets/achievement_grid.dart';
import 'widgets/ai_insight_card.dart';
import 'widgets/habit_streak_card.dart';
import 'widgets/weekly_report_card.dart';

class AICoachScreen extends StatefulWidget {
  const AICoachScreen({super.key});

  @override
  State<AICoachScreen> createState() => _AICoachScreenState();
}

class _AICoachScreenState extends State<AICoachScreen> {
  @override
  void initState() {
    super.initState();

    // Trigger AI generation using the updated UserProvider scheme
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _generateInsight();
    });
  }

  Future<void> _generateInsight() async {
    final user = context.read<UserProvider>().user;
    final usage = context.read<UsageProvider>();

    if (user == null) return;

    // Call Gemini with real runtime user data metrics
    await context.read<GeminiProvider>().generate(
      name: user.name,
      screenHours: usage.totalUsageHours,
      productiveHours: usage.productiveHours.round(),
      lifeScore: user.lifeScore,
      careerGoal: user.careerGoal,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Watch declarations tracking provider updates dynamically
    final gemini = context.watch<GeminiProvider>();
    final user = context.watch<UserProvider>().user;
    final usage = context.watch<UsageProvider>();
    final history = context.watch<HistoryProvider>();

    // Handle early initialization if user object hasn't completed loading yet
    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "AI Coach",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// AI INSIGHT CARD
            gemini.isLoading
                ? const Center(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: CircularProgressIndicator(),
              ),
            )
                : AIInsightCard(
              insight: gemini.insight.isEmpty
                  ? "Generating your AI coach..."
                  : gemini.insight,
            ),

            const SizedBox(height: 25),

            /// WEEKLY REPORT CARD
            WeeklyReportCard(
              productiveHours: usage.productiveHours.round(),
              entertainmentHours: usage.entertainmentHours.round(),
              focusScore: user.focusScore,
              aiSummary: gemini.insight.isEmpty
                  ? "Generating personalized report..."
                  : gemini.insight,
            ),

            const SizedBox(height: 25),

            /// DYNAMIC HABIT STREAK CARDS
            HabitStreakCard(
              title: "Productive Days",
              subtitle: "Last 7 Days",
              streak: history.weeklyImprovement > 0 ? 7 : 3,
              icon: Icons.trending_up,
              color: Colors.green,
              progress: (history.averageLifeScore / 100).clamp(0.0, 1.0),
            ),

            const SizedBox(height: 12),

            HabitStreakCard(
              title: "Productive Focus",
              subtitle: "${user.productiveHours} hr Target",
              streak: 5,
              icon: Icons.psychology,
              color: Colors.orange,
              progress: (user.focusScore / 100).clamp(0.0, 1.0),
            ),

            const SizedBox(height: 12),

            HabitStreakCard(
              title: "Screen Time Tracker",
              subtitle: "${usage.totalUsageHours.toStringAsFixed(1)} hrs today",
              streak: 4,
              icon: Icons.phone_android,
              color: Colors.blue,
              progress: (user.lifeScore / 100).clamp(0.0, 1.0),
            ),

            const SizedBox(height: 25),

            const Text(
              "Achievements",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),

            const AchievementGrid(),
            const SizedBox(height: 30),

            /// SYSTEM INFO BANNER
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.smart_toy,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      "LifeRhythm AI continuously analyses your sleep, productivity, screen time and daily habits. As more data is collected, your coaching and weekly reports become smarter and more personalized.",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.5,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}