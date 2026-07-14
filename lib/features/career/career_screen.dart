import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../providers/gemini_provider.dart';
import '../../core/theme/app_colors.dart';

import 'widgets/pomodoro_timer.dart';

class CareerScreen extends StatelessWidget {
  const CareerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final gemini = context.watch<GeminiProvider>();

    final user = userProvider.user;

    // Part 1 Guard Condition
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
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Career Track",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<UserProvider>().loadUser();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //-------------------------------------------------
              // AI Career Card (Part 1 Integration)
              //-------------------------------------------------
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(.85),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Career AI",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Current Goal",
                      style: TextStyle(
                        color: Colors.white.withOpacity(.85),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      user.careerGoal.isEmpty ? "Not Selected" : user.careerGoal,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      gemini.insight.isEmpty
                          ? "Generate an AI career recommendation based on your Life Score and productivity."
                          : gemini.insight,
                      style: const TextStyle(
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.smart_toy),
                        label: const Text(
                          "Generate AI Advice",
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primary,
                        ),
                        onPressed: () async {
                          await context.read<GeminiProvider>().generate(
                            name: user.name,
                            screenHours: user.totalScreenHours,
                            productiveHours: user.productiveHours,
                            lifeScore: user.lifeScore,
                            careerGoal: user.careerGoal,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              //-------------------------------------------------
              // Pomodoro (Part 1 Integration)
              //-------------------------------------------------
              const PomodoroTimer(),

              const SizedBox(height: 30),

              //-------------------------------------------------
              // Skills Heading
              //-------------------------------------------------
              const Text(
                "Skill Progress",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              //-------------------------------------------------//
              // Dynamic Skill Progress (Part 2 Integration)     //
              //-------------------------------------------------//
              SkillCard(
                title: user.careerGoal.isEmpty ? "Career Goal" : user.careerGoal,
                progress: (user.lifeScore / 100).clamp(0.0, 1.0),
                color: Colors.blue,
              ),
              SkillCard(
                title: "Focus & Productivity",
                progress: (user.focusScore / 100).clamp(0.0, 1.0),
                color: Colors.green,
              ),
              SkillCard(
                title: "Healthy Lifestyle",
                progress: (user.healthScore / 100).clamp(0.0, 1.0),
                color: Colors.red,
              ),
              SkillCard(
                title: "Sleep Consistency",
                progress: (user.sleepScore / 100).clamp(0.0, 1.0),
                color: Colors.indigo,
              ),

              const SizedBox(height: 30),

              //-------------------------------------------------//
              // Overall Progress Card (Part 2 Integration)      //
              //-------------------------------------------------//
              const Text(
                "Overall Career Progress",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: AppColors.primary.withOpacity(.15),
                          child: Text(
                            "${user.lifeScore}",
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Life Progress",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                user.lifeScore >= 80
                                    ? "Excellent progress towards your career."
                                    : user.lifeScore >= 60
                                    ? "You're improving steadily."
                                    : "Let's build stronger daily habits.",
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: LinearProgressIndicator(
                        value: user.lifeScore / 100,
                        minHeight: 12,
                        color: AppColors.primary,
                        backgroundColor: Colors.grey.shade300,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${user.lifeScore}% completed",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              //-------------------------------------------------//
              // Today's Goal (Part 3 Integration)               //
              //-------------------------------------------------//
              const Text(
                "Today's Goal",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.green.withOpacity(.15),
                      child: const Icon(
                        Icons.flag,
                        color: Colors.green,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.careerGoal.isEmpty
                                ? "Choose a Career Goal"
                                : "Work towards becoming a ${user.careerGoal}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Complete ${user.productiveHours} productive hours today.",
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 30),

              //-------------------------------------------------//
              // Deep Work (Part 3 Integration)                  //
              //-------------------------------------------------//
              const Text(
                "Deep Work Timer",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
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
                  children: [
                    const Icon(
                      Icons.timer,
                      size: 70,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "25 : 00",
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Complete a distraction-free session.",
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.play_arrow),
                        label: const Text(
                          "Start Focus Session",
                        ),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(
                            double.infinity,
                            55,
                          ),
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              //-------------------------------------------------//
              // AI Recommendation (Part 3 Integration)          //
              //-------------------------------------------------//
              const Text(
                "AI Recommendation",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: AppColors.primary.withOpacity(.15),
                      child: Icon(
                        Icons.smart_toy,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        gemini.insight.isEmpty
                            ? "Generate AI advice to receive personalized career recommendations based on your productivity, focus score and career goal."
                            : gemini.insight,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              //-------------------------------------------------//
              // Achievements (Part 4 Integration)               //
              //-------------------------------------------------//
              const Text(
                "Achievements",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: .95,
                children: [
                  AchievementCard(
                    title: "Life Master",
                    icon: Icons.emoji_events,
                    color: Colors.amber,
                    unlocked: user.lifeScore >= 80,
                  ),
                  AchievementCard(
                    title: "Sleep Hero",
                    icon: Icons.bedtime,
                    color: Colors.indigo,
                    unlocked: user.sleepScore >= 80,
                  ),
                  AchievementCard(
                    title: "Focus Pro",
                    icon: Icons.psychology,
                    color: Colors.green,
                    unlocked: user.focusScore >= 75,
                  ),
                  AchievementCard(
                    title: "Healthy You",
                    icon: Icons.favorite,
                    color: Colors.red,
                    unlocked: user.healthScore >= 75,
                  ),
                ],
              ),
              const SizedBox(height: 35),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      color: AppColors.primary,
                      size: 50,
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Keep Improving!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Every productive hour, healthy habit and focused session helps you move closer to your dream career.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

//-------------------------------------------------//
// Upgraded SkillCard Widget (Part 4 Integration)  //
//-------------------------------------------------//
class SkillCard extends StatelessWidget {
  final String title;
  final double progress;
  final Color color;

  const SkillCard({
    super.key,
    required this.title,
    required this.progress,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
                Text(
                  "${(progress * 100).toInt()}%",
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                color: color,
                backgroundColor: Colors.grey.shade300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//-------------------------------------------------//
// Upgraded AchievementCard Widget (Part 4)        //
//-------------------------------------------------//
class AchievementCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final bool unlocked;

  const AchievementCard({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.unlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: unlocked ? Colors.white : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.08),
            blurRadius: 8,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: unlocked ? color.withOpacity(.15) : Colors.grey.shade300,
            child: Icon(
              icon,
              color: unlocked ? color : Colors.grey,
              size: 32,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: unlocked ? Colors.black : Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: unlocked ? Colors.green.withOpacity(.15) : Colors.grey.withOpacity(.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              unlocked ? "Unlocked" : "Locked",
              style: TextStyle(
                color: unlocked ? Colors.green : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}