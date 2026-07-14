import 'package:flutter/material.dart';

class AchievementGrid extends StatelessWidget {
  const AchievementGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: achievements.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, index) {
        return AchievementTile(
          achievement: achievements[index],
        );
      },
    );
  }
}

class Achievement {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final bool unlocked;

  const Achievement({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.unlocked,
  });
}

const List<Achievement> achievements = [

  Achievement(
    title: "Focus Master",
    subtitle: "25 Focus Sessions",
    icon: Icons.psychology,
    color: Colors.deepPurple,
    unlocked: true,
  ),

  Achievement(
    title: "Sleep Champion",
    subtitle: "7-Day Sleep Streak",
    icon: Icons.bedtime,
    color: Colors.indigo,
    unlocked: true,
  ),

  Achievement(
    title: "Hydration Hero",
    subtitle: "Drink 2L Daily",
    icon: Icons.water_drop,
    color: Colors.blue,
    unlocked: false,
  ),

  Achievement(
    title: "Learning Beast",
    subtitle: "50 Study Hours",
    icon: Icons.menu_book,
    color: Colors.green,
    unlocked: true,
  ),

  Achievement(
    title: "Digital Detox",
    subtitle: "Under Screen Limit",
    icon: Icons.phone_android,
    color: Colors.red,
    unlocked: false,
  ),

  Achievement(
    title: "Productivity Pro",
    subtitle: "Life Score > 80",
    icon: Icons.emoji_events,
    color: Colors.orange,
    unlocked: true,
  ),
];

class AchievementTile extends StatelessWidget {
  final Achievement achievement;

  const AchievementTile({
    super.key,
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: achievement.unlocked
            ? Colors.white
            : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.12),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 18,
        ),
        child: Column(
          children: [

            Stack(
              children: [

                CircleAvatar(
                  radius: 28,
                  backgroundColor: achievement.unlocked
                      ? achievement.color.withOpacity(.15)
                      : Colors.grey.shade300,
                  child: Icon(
                    achievement.icon,
                    size: 30,
                    color: achievement.unlocked
                        ? achievement.color
                        : Colors.grey,
                  ),
                ),

                if (!achievement.unlocked)
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.lock,
                        size: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 16),

            Text(
              achievement.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: achievement.unlocked
                    ? Colors.black
                    : Colors.grey,
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: Center(
                child: Text(
                  achievement.subtitle,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    color: achievement.unlocked
                        ? Colors.grey.shade700
                        : Colors.grey,
                  ),
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: achievement.unlocked
                    ? Colors.green.withOpacity(.15)
                    : Colors.grey.withOpacity(.15),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                achievement.unlocked
                    ? "Unlocked"
                    : "Locked",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: achievement.unlocked
                      ? Colors.green
                      : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}