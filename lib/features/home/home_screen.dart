import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../models/daily_history_model.dart';
import '../../providers/history_provider.dart';
import '../../providers/usage_provider.dart';
import '../../providers/user_provider.dart';
import 'widgets/ai_daily_plan_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<UserProvider>().loadUser();
      await context.read<UsageProvider>().loadUsage();
      await context.read<HistoryProvider>().loadHistory();
      await _saveTodayHistory();
    });
  }

  Future<void> _saveTodayHistory() async {
    final userProvider = context.read<UserProvider>();
    final usageProvider = context.read<UsageProvider>();
    final historyProvider = context.read<HistoryProvider>();

    final user = userProvider.user;
    if (user == null) return;

    final history = DailyHistoryModel(
      date: DateTime.now().toIso8601String().substring(0, 10),
      sleepHours: user.sleepHours,
      bedtime: user.bedtime,
      wakeupTime: user.wakeup,
      productiveHours: usageProvider.productiveHours,
      completedPomodoros: 0,
      totalScreenHours: usageProvider.totalUsageHours,
      entertainmentHours: usageProvider.entertainmentHours,
      productiveScreenHours: usageProvider.productiveHours,
      waterIntake: user.waterIntake,
      exerciseMinutes: user.exerciseMinutes,
      lifeScore: user.lifeScore,
      sleepScore: user.sleepScore,
      focusScore: user.focusScore,
      healthScore: user.healthScore,
      aiInsight: historyProvider.aiInsight,
    );

    await historyProvider.autoSaveToday(history);
  }

  String greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning ☀️";
    }
    if (hour < 17) {
      return "Good Afternoon 🌤";
    }
    if (hour < 20) {
      return "Good Evening 🌇";
    }
    return "Good Night 🌙";
  }

  Color scoreColor(int score) {
    if (score >= 80) {
      return Colors.green;
    }
    if (score >= 60) {
      return Colors.orange;
    }
    return Colors.red;
  }

  String scoreStatus(int score) {
    if (score >= 80) {
      return "Aligned";
    }
    if (score >= 60) {
      return "Balanced";
    }
    return "Drifting";
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final usage = context.watch<UsageProvider>();
    final history = context.watch<HistoryProvider>();

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "LifeRhythm",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 18,
              child: Text(
                user.name.isEmpty ? "U" : user.name[0].toUpperCase(),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              greeting(),
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              user.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  SizedBox(
                    height: 110,
                    width: 110,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: 10,
                          value: user.lifeScore / 100,
                          backgroundColor: Colors.grey.shade300,
                          color: scoreColor(user.lifeScore),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${user.lifeScore}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            ),
                            Text(
                              scoreStatus(user.lifeScore),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 25),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Life Drift Score",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          history.aiInsight.isEmpty
                              ? "Your Life Score is calculated using sleep, productivity and screen time."
                              : history.aiInsight,
                          style: const TextStyle(
                            color: Colors.grey,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 25),

            /// TODAY'S STATISTICS
            const Text(
              "Today's Statistics",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.15,
              children: [
                DashboardCard(
                  icon: Icons.phone_android,
                  title: "Screen Time",
                  value: "${usage.totalUsageHours.toStringAsFixed(1)} hrs",
                  color: Colors.orange,
                ),
                DashboardCard(
                  icon: Icons.work,
                  title: "Productive",
                  value: "${usage.productiveHours.toStringAsFixed(1)} hrs",
                  color: Colors.green,
                ),
                DashboardCard(
                  icon: Icons.bedtime,
                  title: "Sleep",
                  value: "${user.sleepHours.toStringAsFixed(1)} hrs",
                  color: Colors.indigo,
                ),
                DashboardCard(
                  icon: Icons.favorite,
                  title: "Health",
                  value: "${user.healthScore}",
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 30),

            /// MOST USED APP
            const Text(
              "Most Used App",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.blue.shade50,
                    child: const Icon(
                      Icons.apps,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          usage.mostUsedApp?.appName ?? "No Data",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          usage.mostUsedApp?.formattedTime ?? "0m",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            /// GOALS
            const Text(
              "Today's Goals",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.workspace_premium,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          user.careerGoal,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(
                        Icons.psychology,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Productive Goal : ${user.productiveHours} hrs",
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(
                        Icons.phone_android,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Screen Limit : ${user.screenTime.toStringAsFixed(1)} hrs",
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            /// WEEKLY PERFORMANCE
            const Text(
              "Weekly Performance",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.trending_up,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        history.improving
                            ? "Your routine is improving 📈"
                            : "Let's improve this week 💪",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    "Average Life Score : ${history.averageLifeScore.toStringAsFixed(1)}",
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Average Productive Hours : ${history.averageProductiveHours.toStringAsFixed(1)} hrs",
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Average Screen Time : ${history.averageScreenTime.toStringAsFixed(1)} hrs",
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Weekly Improvement : ${history.weeklyImprovement}",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            /// AI COACH
            const Text(
              "LifeRhythm AI",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff4F8EF7),
                    Color(0xff7B61FF),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.smart_toy,
                          color: Color(0xff4F8EF7),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        "Today's Recommendation",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    history.aiInsight.isNotEmpty
                        ? history.aiInsight
                        : "You're making good progress today. Stay consistent, reduce unnecessary screen time and maintain your healthy routine.",
                    style: const TextStyle(
                      color: Colors.white,
                      height: 1.6,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.15),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.lightbulb,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            user.lifeScore >= 80
                                ? "Excellent consistency! Maintain your current routine."
                                : user.lifeScore >= 60
                                ? "Reduce screen time by 30 minutes today."
                                : "Focus on sleep and productive work today.",
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),

            /// AI DAILY PLAN
            const AIDailyPlanCard(),
            const SizedBox(height: 30),

            /// QUICK ACTIONS
            const Text(
              "Quick Actions",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.analytics,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Analytics",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.smart_toy,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "AI Coach",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Center(
              child: Text(
                "LifeRhythm • Version 1.0",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.10),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: color.withOpacity(.15),
            child: Icon(
              icon,
              color: color,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}